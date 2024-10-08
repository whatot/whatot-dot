;;; init-font --- only font -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'cl-lib)
(defvar doom-font)
(defvar doom-unicode-font)

(defvar +font-size
  (pcase (system-name)
    ("gs65" 18)
    ("b150" 32)
    ("star" 14)
    ("mercury" 14)))

;; https://www.emacswiki.org/emacs/SetFonts
(defun +match-font-p (fonts)
  "Return existing font which first match in FONTS."
  (cl-loop for font in fonts
           when (find-font (font-spec :family font))
           return (font-spec :family font :size +font-size)))

(defvar +prefer-en-fonts '("JetBrainsMono Nerd Font" "Hack Nerd Font"
                           "Source Code Pro" "Hack" "Menlo" "monospace"))
(defvar +prefer-cjk-fonts '("LXGW WenKai" "Source Han Sans CN" "monospace"))
(defvar +prefer-emoji-fonts '("Apple Color Emoji" "Noto Color Emoji"))
(defvar +prefer-symbol-fonts '("Apple Symbols" "Noto Sans Symbols"))
(defvar +en-font (+match-font-p +prefer-en-fonts))
(defvar +cjk-font (+match-font-p +prefer-cjk-fonts))
(defvar +emoji-font (+match-font-p +prefer-emoji-fonts))
(defvar +symbol-font (+match-font-p +prefer-symbol-fonts))

(setq doom-font +en-font)
(setq doom-unicode-font +cjk-font)
(add-hook 'after-init-hook
          (lambda ()
            ;; cjk check 语言 中文 早上好 おはよう 좋은 아침이에요
            (dolist (charset '(han kana hangul cjk-misc))
              (set-fontset-font "fontset-default" charset +cjk-font))
            ;; ¢ $ € £ ¥
            (dolist (charset '(greek symbol))
              (set-fontset-font "fontset-default" charset +symbol-font nil 'prepend))
            ;; emoji check 😀 😃 🫱🏼‍🫲🏿
            (set-fontset-font "fontset-default" 'emoji +emoji-font)))

(provide 'init-font)
;;; init-font.el ends here
