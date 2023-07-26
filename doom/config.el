
;;; font
(defun config-font-size (size)
  (setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size size))
  ;;(setq doom-font (font-spec :family "Hack Nerd Font" :size size))
  (setq doom-unicode-font (font-spec :family "LXGW Bright GB")))
(cond
 ((string= (system-name) "msi") (config-font-size 18))
 ((string= (system-name) "gs65") (config-font-size 18))
 ((string= (system-name) "b150") (config-font-size 32))
 ((string= system-type "darwin") (config-font-size 14)))

;;; windows frame title
(setq frame-title-format
          '(buffer-file-name "%f [%m]"
            (dired-directory dired-directory "%b")))

;;; maximized at startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . fullheight))

(setq-default truncate-lines nil)
(setq-default word-wrap nil)
(setq-default show-trailing-whitespace t)
(setq-default require-final-newline t)

;;; quick exit emacs without comfirm
(setq-default confirm-kill-emacs nil)

;; Replace annoying yes/no prompt with a y/n prompt
(fset 'yes-or-no-p 'y-or-n-p)

(setq byte-compile-warnings '(cl-functions))

;; disable warning generated when functions are redefined with defadvice
(setq ad-redefinition-action 'accept)

(prefer-coding-system 'utf-8)

;; 增大同LSP服务器交互时的读取文件的大小 128MB
(setq read-process-output-max (* 1024 1024 128))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; enable tree-sitter global
(setq global-tree-sitter-mode 1)

;; make treemacs automatically switch to the project for the current buffer.
(after! treemacs
  (treemacs-follow-mode 1))

;; https://github.com/lorniu/go-translate/blob/master/README-zh.md
(use-package! go-translate
  :demand t
  :config
  (map! "C-c y" 'gts-do-translate))
(setq gts-translate-list '(("en" "zh")))
(setq gts-default-translator
      (gts-translator
       :picker (gts-noprompt-picker :texter (gts-current-or-selection-texter) :single t)
       :engines (list (gts-bing-engine) (gts-google-rpc-engine))
       :render (gts-posframe-pop-render :width 120 :height 32)))

(use-package! fcitx
  :if (string= system-type 'gnu/linux)
  :after evil
  :config
  (when (executable-find "fcitx-remote") (fcitx-evil-turn-on)))

;; config plantuml-jar-path
(setq-default plantuml-jar-path
              (cond ((string= system-type 'darwin)
                     "/usr/local/opt/plantuml/libexec/plantuml.jar")
                    ((string= system-type 'gnu/linux)
                     "/usr/share/java/plantuml/plantuml.jar")))
(setq-default org-plantuml-jar-path (expand-file-name plantuml-jar-path))
(setq-default plantuml-default-exec-mode 'jar)

;; Beacon — Never lose your cursor again
(beacon-mode 1)

;; for edit vim file in emacs
(use-package! vimrc-mode
  :mode ("\\.vim\\(rc\\)?\\'" . vimrc-mode))

;; use fmt in golang for missing fmt
(use-package! markdownfmt
  :after markdown-mode
  :config (add-hook 'markdown-mode-hook #'markdownfmt-enable-on-save))

;; optional as clangd is the default cc lsp in Doom
(after! lsp-clangd
  (setq lsp-clients-clangd-args
        '("-j=3"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=never"
          "--header-insertion-decorators=0"))
  (set-lsp-priority! 'clangd 2))

;; config dired
(setq dired-dwim-target t)
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default my-proxy "127.0.0.1:8899")
(defun show-proxy ()
  "Show http/https proxy."
  (interactive)
  (if url-proxy-services
      (message "Current proxy is \"%s\"" my-proxy)
    (message "No proxy")))

(defun set-proxy ()
  "Set http/https proxy."
  (interactive)
  (setq url-proxy-services `(("http" . ,my-proxy)
                             ("https" . ,my-proxy)))
  (show-proxy))

(defun unset-proxy ()
  "Unset http/https proxy."
  (interactive)
  (setq url-proxy-services nil)
  (show-proxy))

(defun toggle-proxy ()
  "Toggle http/https proxy."
  (interactive)
  (if url-proxy-services
      (unset-proxy)
    (set-proxy)))

(set-proxy)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
