;;; init-org --- config org with plugins -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defvar +is-star (string= (system-name) "star"))

(defvar org-directory)
(setq org-directory
      (file-truename (if +is-star "~/org" "~/nutstore/org")))

(defvar org-roam-directory)
(setq org-roam-directory
      (file-truename (if +is-star "~/org/roam" "~/nutstore/org/roam")))

;; https://emacs-china.org/t/org-ql-columnview-org-roam-org-capture-org-super-links/21599
(defvar org-roam-capture-templates)
(setq org-roam-capture-templates
      '(
        ("d" "default" plain "%?"
         :target (file+head "inbox/%<%Y%m%d>-${slug}.org"
                            "#+title: ${title}\n#+filetags: \n")
         :unnarrowed t)
        ("b" "book notes" plain "%?"
         :target (file+head "book/book-%<%Y%m%d>-${slug}.org"
                            "#+title: ${title}\n#+filetags: :book:\n\n")
         :unnarrowed t)
        ("a" "algorithm" plain "%?"
         :target (file+head "algorithm/algorithm-%<%Y%m%d>-${slug}.org"
                            "#+title: ${title}\n#+filetags: :algorithm:\n\n")
         :unnarrowed t)
        ("d" "data science" plain "%?"
         :target (file+head "data/data-%<%Y%m%d>-${slug}.org"
                            "#+title: ${title}\n#+filetags: :data:\n\n")
         :unnarrowed t)
        ("e" "engineering" plain "%?"
         :target (file+head "engineering/engineering-%<%Y%m%d>-${slug}.org"
                            "#+title: ${title}\n#+filetags: :engineering:\n\n")
         :unnarrowed t)
        ("h" "homelab" plain "%?"
         :target (file+head "homelab/homelab-%<%Y%m%d>-${slug}.org"
                            "#+title: ${title}\n#+filetags: :homelab:\n\n")
         :unnarrowed t)
        ("m" "work month" plain "%?"
         :target (file+head "work/month-${slug}.org"
                            "#+title: ${title}\n#+filetags: :work:month:\n\n")
         :unnarrowed t)
        ("p" "project" plain "%?"
         :target (file+head "project/project-%<%Y%m%d>-${slug}.org"
                            "#+title: ${title}\n#+filetags: :project:\n\n")
         :unnarrowed t)
        ("t" "tools" plain "%?"
         :target (file+head "tools/tools-%<%Y%m%d>-${slug}.org"
                            "#+title: ${title}\n#+filetags: :tools:\n\n")
         :unarrowed t)
        ))


(provide 'init-org)
;;; init-org.el ends here
