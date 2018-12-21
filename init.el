;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-


;; パッケージの設定----------------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa". "http://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))

;;; パッケージ自動インストール 
(defvar favorite-package-list ; インストールしたいパッケージをここに記述
  '(helm
    company
    undo-tree)
  "packages to be installed")
(dolist (pkg favorite-package-list)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;;; helm
(require 'helm-config)
(helm-mode)
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)
(define-key global-map (kbd "M-r")     'helm-resume)
(define-key global-map (kbd "C-M-h")   'helm-apropos)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;;; company
(require 'company)
(global-company-mode)

(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
					;キーバインドの設定
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-h") nil)
(defun company--insert-candidate2 (candidate)
  (when (> (length candidate) 0)
    (setq candidate (substring-no-properties candidate))
    (if (eq (company-call-backend 'ignore-case) 'keep-prefix)
        (insert (company-strip-prefix candidate))
      (if (equal company-prefix candidate)
          (company-select-next)
	(delete-region (- (point) (length company-prefix)) (point))
        (insert candidate))
      )))

(defun company-complete-common2 ()
  (interactive)
  (when (company-manual-begin)
    (if (and (not (cdr company-candidates))
             (equal company-common (car company-candidates)))
        (company-complete-selection)
      (company--insert-candidate2 company-common))))

(define-key company-active-map [tab] 'company-complete-common2)
(define-key company-active-map [backtab] 'company-select-previous) ; おまけ

;;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

;; emacsサーバー------------------------------------------------------------------------------
(require 'server)
(when (and (>= emacs-major-version 23)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t))
  ; Suppress error "directory ~/.emacs.d/server is unsafe" on windows.
(unless (server-running-p)
  (server-start))
(remove-hook
  'kill-buffer-query-functions
  'server-kill-buffer-query-function)

;; scratch消去防止----------------------------------------------------------------------------
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*" を作成して buffer-list に放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))

(add-hook 'kill-buffer-query-functions
          ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (progn (my-make-scratch 0) nil)
              t)))

(add-hook 'after-save-hook
          ;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
          (lambda ()
            (unless (member (get-buffer "*scratch*") (buffer-list))
              (my-make-scratch 1))))

;; 文字コード---------------------------------------------------------------------------------
(set-language-environment "Japanese")
(global-unset-key (kbd "C-\\")) ; インプットメソッドの切り替えをオフにする
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-file-name-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(setq default-process-coding-system '(undecided-dos . utf-8-unix))
;;; 環境依存文字 文字化け対応
(set-charset-priority 'ascii 'japanese-jisx0208 'latin-jisx0201
                      'katakana-jisx0201 'iso-8859-1 'cp1252 'unicode)
(set-coding-system-priority 'utf-8 'euc-jp 'iso-2022-jp 'cp932)

;; 検索--------------------------------------------------------------------------------------
(setq-default case-fold-search nil) ; 大文字・小文字を区別しないでサーチ(有効：t、無効：nil)
(setq isearch-allow-scroll t) ; インクリメント検索時に縦スクロールを有効化
(define-key isearch-mode-map (kbd "C-d") 'isearch-delete-char ) ; C-dで検索文字列を一文字削除
(define-key isearch-mode-map (kbd "C-y") 'isearch-yank-kill) ; C-yで検索文字列にヤンク貼り付け
(define-key isearch-mode-map (kbd "C-e") 'isearch-edit-string) ; C-eで検索文字列を編集
(define-key isearch-mode-map (kbd "TAB") 'isearch-yank-word) ; Tabで検索文字列を補完
(define-key isearch-mode-map (kbd "C-g") ; C-gで検索を終了
  '(lambda() (interactive) (isearch-done)))

;; その他のカスタム----------------------------------------------------------------------------
;;; フォントサイズ
(global-set-key (kbd "C-+") '(lambda() (interactive) (text-scale-increase 1)))
(global-set-key (kbd "C--") '(lambda() (interactive) (text-scale-decrease 1)))
(global-set-key (kbd "C-0") '(lambda() (interactive) (text-scale-set 0)))

;;; 色分け
(show-paren-mode 1) ; 対応する括弧をハイライトする
(setq show-paren-style 'mixed) ; 対応する括弧の色の設定
(set-face-background 'show-paren-match-face "grey")
(set-face-foreground 'show-paren-match-face "black")
(global-font-lock-mode t) ; 予約語を色分けする

;;; インデント
(electric-indent-mode t) ; 自動インデント
(add-hook 'c-mode-common-hook ; c-mode のインデントをスペース4個分のタブにする
          '(lambda ()
             (c-set-style "k&r")
	     (setq c-basic-offset 4)
	     (setq indent-tabs-mode nil)
	     (setq tab-width 4)))

;;; 行
(require 'linum)
(global-linum-mode) ; 左に行番号を表示
(global-set-key "\M-g" 'goto-line) ; goto-lineをM-gに割り当てる
(global-set-key (kbd "M-;") 'comment-or-uncomment-region) ; スマートなコメントアウト

;;; カラムの移動
(global-set-key "\C-xp" (lambda () (interactive) (other-window -1))) ; Ctrl-x p で逆向きのウィンドウ移動
(global-set-key (kbd "M-<left>")  'windmove-left)
(global-set-key (kbd "M-<down>")  'windmove-down)
(global-set-key (kbd "M-<up>")    'windmove-up)
(global-set-key (kbd "M-<right>") 'windmove-right)

;;; その他のその他
(fset 'yes-or-no-p 'y-or-n-p) ; yesとnoをyとnにする
(global-set-key (kbd "<f5>") 'revert-buffer) ; reload buffer

;; 自動カスタム（いじらない）--------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(doc-view-continuous t)
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (undo-tree company helm)))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode (quote (only . t)))
 '(verilog-auto-newline nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 128 :width normal)))))

