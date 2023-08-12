;;; init-ui --- ui except font -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; windows frame title
(setq frame-title-format
          '(buffer-file-name "%f [%m]"
            (dired-directory dired-directory "%b")))

;;; maximized,no title at startup
(setq default-frame-alist
      '(
        (undecorated . t);会导致所有边框全部消失无法拖动调整窗口大小 需要加上后面两句
        (drag-internal-border . 1)
        (internal-border-width . 5)
        (vertical-scroll-bars);隐藏滚动条
        (left-fringe);显示左fringe
        (right-fringe . 0);关闭右fringe
        (fullscreen . maximized)
        (fullscreen . fullheight)
        ))

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

;; auto save global
(add-hook 'after-init-hook #'auto-save-visited-mode)

(provide 'init-ui)
;;; init-ui.el ends here
