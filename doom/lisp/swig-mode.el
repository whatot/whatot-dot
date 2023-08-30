;;; swig-mode.el ---

;; Copyright 2006 Ye Wenbin
;;
;; Author: wenbinye@163.com
;; Time-stamp: <Ye Wenbin 2007-12-07 21:30:21>
;; Version: $Id: swig-mode.el,v 1.1.1.1 2007-03-13 13:16:10 ywb Exp $
;; Keywords:
;; X-URL: not distributed yet

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;;

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'swig-mode)

;;; Code:

(eval-when-compile
  (require 'cl))

(require 'tempo)


;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################

(defvar swig-directive
  '("include" "feature" "contract" "newobject" "immutable"
    "mutable" "ignore" "init"
    "rename" "module" "goops" "except" "extend" "import"
    "typemap" "types" "inline" "pragma"
    "array_functions" "array_class")
  "directive of swig")

(defvar swig-font-lock-keywords
  `(("%\\sw+"
    ;; (,(concat "\\(%\\(?:" (mapconcat 'identity swig-directive "\\|") "\\)\\)")
    0 font-lock-keyword-face)
    ("\\(%module\\)\\s-+\\(\\sw+\\)"
     (1 font-lock-keyword-face)
     (2 font-lock-function-name-face)))
  "font lock for swig mode")

(defvar tempo-swig-tags nil
  "Tempo for swig mode")

(tempo-define-template
 "swig-directive"
 `("%"
   (pi ,(cons "Directive: " swig-directive) nil dir)
   (let ((dir (tempo-lookup-named 'dir)))
     (cond ((string= dir "module") " ")
           ((string= dir "immutable")
            '(l ";\n" p "\n%mutable;\n"))
           ((member dir '("mutable"))
            ";\n")
           (t '(l " %{\n" p "\n%}")))))
 "directive"
 "Insert swig directive"
 'tempo-swig-tags)

;;;###autoload
(define-derived-mode swig-mode c++-mode "Swig"
  "Major mode for Asymptote."
  (local-set-key "{" 'swig-insert-paren)
  (setq c++-font-lock-keywords-3
        (append c++-font-lock-keywords-3
                swig-font-lock-keywords)))

(defun swig-insert-paren ()
  ""
  (interactive)
  (if (looking-back "%")
      (progn
        (insert "{\n\n%}")
        (backward-char 3))
    (call-interactively 'self-insert-command)))

(defun swig-mode-install ()
  "Install SWIG mode."
  (tempo-use-tag-list 'tempo-swig-tags))

(add-hook 'swig-mode-hook 'swig-mode-install)


(provide 'swig-mode)
;;; swig-mode.el ends here
