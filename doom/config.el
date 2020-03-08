
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
 ((string= (system-name) "x411") (config-font-size 18 16))
 ((string= (system-name) "b150") (config-font-size 32 30))
 ((string= system-type "darwin") (config-font-size 14 13)))

;;; windows frame title
(setq frame-title-format
          '(buffer-file-name "%f [%m]"
            (dired-directory dired-directory "%b")))

;;; maximized at startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . fullheight))

(use-package! youdao-dictionary
  :demand t
  :commands (youdao-dictionary-search-at-point)
  :config (map! "C-c y" 'youdao-dictionary-search-at-point+))

(use-package! fcitx
  :after evil
  :config
  (when (executable-find "fcitx-remote") (fcitx-evil-turn-on)))

(setq-default truncate-lines nil)
(setq-default word-wrap nil)
(setq-default show-trailing-whitespace t)
(setq-default require-final-newline t)

;;; rust about
(setq-default rust-format-on-save t)
(setq rustic-lsp-server 'rust-analyzer)

;;; quick exit emacs without comfirm
(setq-default confirm-kill-emacs nil)

;;; config plantuml-jar-path
(setq-default plantuml-jar-path
              (cond ((string= system-type "darwin")
                     "/usr/local/Cellar/plantuml/1.2019.11/libexec/plantuml.jar")
                    ((string= system-type "gnu/linux")
                     "/usr/share/java/plantuml/plantuml.jar")))
(setq-default org-plantuml-jar-path (expand-file-name plantuml-jar-path))
(setq-default plantuml-default-exec-mode 'jar)

;; Configure network proxy
(setq-default my-proxy "127.0.0.1:7890")
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
