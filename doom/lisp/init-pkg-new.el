;;; init-pkg-new --- config self-installed -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; use sqlformat
(use-package! sqlformat
  :demand t
  :config
  (setq sqlformat-command 'sqlformat)
  (setq sqlformat-args '())
  (add-hook 'sql-mode-hook 'sqlformat-on-save-mode))

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

;; for edit vim file in emacs
(use-package! vimrc-mode
  :mode ("\\.vim\\(rc\\)?\\'" . vimrc-mode))

;; use fmt in golang for missing fmt
(use-package! markdownfmt
  :after markdown-mode
  :config (add-hook 'markdown-mode-hook #'markdownfmt-enable-on-save))

(provide 'init-pkg-new)
;;; init-pkg-new.el ends here
