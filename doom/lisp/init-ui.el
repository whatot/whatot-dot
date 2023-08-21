;;; init-ui --- ui except font -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; windows frame title
(setq frame-title-format
          '(buffer-file-name "%f [%m]"
            (dired-directory dired-directory "%b")))

;;; maximized,no titlebar at startup
(if (eq system-type 'darwin)
    ;; in macos, original undecorated conflict with maximized-toggle
    (add-to-list 'default-frame-alist '(undecorated-round . t))
  ;; in linux, undecorated-round conflict with maximized-toggle
  (add-to-list 'default-frame-alist '(undecorated . t)))
(add-to-list 'default-frame-alist '(drag-internal-border . 1))
(add-to-list 'default-frame-alist '(internal-border-width . 5))
(add-to-list 'default-frame-alist '(drag-with-tab-line . t))
(add-to-list 'default-frame-alist '(vertical-scroll-bars))
(add-hook 'window-setup-hook #'toggle-frame-maximized)

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
