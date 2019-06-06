
;;; font
(setq doom-font (font-spec
                 :family "Source Code Pro"
                 :size (cond
                        ((string= (system-name) "x411") '19)
                        ((string= (system-name) "b150") '30)
                        ((string= system-type "darwin") '14))))
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

(setq-default truncate-lines nil)
(setq-default word-wrap t)
(setq-default show-trailing-whitespace t)
(setq-default require-final-newline t)

;;; quick exit emacs without comfirm
(setq-default confirm-kill-emacs nil)
