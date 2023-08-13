;;; init-pkg-builtin --- config module pkgs -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; enable tree-sitter global
(setq global-tree-sitter-mode 1)

;; make treemacs automatically switch to the project for the current buffer.
(after! treemacs
  (treemacs-follow-mode 1))

;; Beacon — Never lose your cursor again
(beacon-mode 1)

;; support plantuml
(after! plantuml-mode
  (setq plantuml-default-exec-mode 'executable)
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
  )

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

(provide 'init-pkg-builtin)
;;; init-pkg-builtin.el ends here
