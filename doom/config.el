
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

(def-package! youdao-dictionary
  :demand t
  :commands (youdao-dictionary-search-at-point)
  :config (map! "C-c y" 'youdao-dictionary-search-at-point+))

(def-package! fcitx
  :after evil
  :config
  (when (executable-find "fcitx-remote") (fcitx-evil-turn-on)))

(setq-default truncate-lines nil)
(setq-default word-wrap t)
(setq-default show-trailing-whitespace t)
(setq-default require-final-newline t)
(setq-default rust-format-on-save t)

;;; quick exit emacs without comfirm
(setq-default confirm-kill-emacs nil)
