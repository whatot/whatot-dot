;;; init-optimize --- all for speed -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; 增大同LSP服务器交互时的读取文件的大小 128MB
(setq read-process-output-max (* 1024 1024 128))

;; https://emacs-lsp.github.io/lsp-mode/page/performance/#use-plists-for-deserialization
(defvar lsp-use-plists)
(setq lsp-use-plists t)

(prefer-coding-system 'utf-8)

(provide 'init-optimize)
;;; init-optimize.el ends here
