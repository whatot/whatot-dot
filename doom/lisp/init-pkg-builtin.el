;;; init-pkg-builtin --- config module pkgs -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; enable tree-sitter global
(setq global-tree-sitter-mode 1)

;; make treemacs automatically switch to the project for the current buffer.
(after! treemacs
  (treemacs-follow-mode 1))

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
