
;;; font
(defun config-font-size (en-size cn-size)
  (setq doom-font (font-spec
                   :family "Source Code Pro"
                   :size en-size))
  (set-face-attribute 'default nil :font
                      (format "%s:pixelsize=%d" "Source Code Pro" en-size))
  (if (display-graphic-p)
      (dolist (charset '(kana han cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font) charset
                          (font-spec :family "Source Han Sans CN" :size cn-size)))))
(cond
 ((string= (system-name) "msi") (config-font-size 18 16))
 ((string= (system-name) "gs65") (config-font-size 18 16))
 ((string= (system-name) "b150") (config-font-size 32 30))
 ((string= system-type "darwin") (config-font-size 14 13)))

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

(use-package! youdao-dictionary
  :demand t
  :commands (youdao-dictionary-search-at-point)
  :config (map! "C-c y" 'youdao-dictionary-search-at-point+))

(use-package! fcitx
  :after evil
  :config
  (when (executable-find "fcitx-remote") (fcitx-evil-turn-on)))

;; config plantuml-jar-path
(setq-default plantuml-jar-path
              (cond ((string= system-type "darwin")
                     "/usr/local/opt/plantuml/libexec/plantuml.jar")
                    ((string= system-type "gnu/linux")
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

; optional as clangd is the default cc lsp in Doom
(after! lsp-clangd
  (setq lsp-clients-clangd-args
        '("-j=3"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=never"
          "--header-insertion-decorators=0"))
  (set-lsp-priority! 'clangd 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default my-proxy "127.0.0.1:8890")
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
