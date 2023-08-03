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

;; https://emacs.stackexchange.com/questions/30520/org-mode-c-c-c-c-to-display-inline-image
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)

;; https://emacs-china.org/t/org-ql-columnview-org-roam-org-capture-org-super-links/21599
(defvar org-roam-capture-templates)
(setq org-roam-capture-templates
      '(
        ("d" "default" plain "%?"
         :target (file+head "inbox/%<%Y%m%d>-${slug}.org"
                            "#+title: ${title}\n#+filetags: \n")
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
        ("o" "owned topic" plain "%?"
         :target (file+head "topic/${slug}.org"
                            "#+title: ${title}\n#+filetags: :topic:\n\n")
         :unnarrowed t)
        ("m" "work monthly in 2023" plain "* ${title} :work:\n :PROPERTIES:\n :ID: %(org-id-uuid)\n:END:\n\n"
         :target (file+olp "work/year-2023.org" ("Year 2023"))
         :unnarrowed t)
        ("p" "project in work" plain "%?"
         :target (file+head "work/project-%<%Y%m%d>-${slug}.org"
                            "#+title: ${title}\n#+filetags: :work:project:\n\n")
         :unnarrowed t)
        ("t" "tools" plain "%?"
         :target (file+head "tools/tools-%<%Y%m%d>-${slug}.org"
                            "#+title: ${title}\n#+filetags: :tools:\n\n")
         :unarrowed t)
        ))


(provide 'init-org)
;;; init-org.el ends here
