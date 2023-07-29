;;; init-org --- config org with plugins -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defvar org-directory)
(defvar org-roam-directory)
(defvar org-roam-dailies-capture-templates)

(defvar +is-star (string= (system-name) "star"))

(setq org-directory
      (file-truename (if +is-star "~/org" "~/nutstore/org")))
(setq org-roam-directory
      (file-truename (if +is-star "~/org/roam" "~/nutstore/org/roam")))

(provide 'init-org)
;;; init-org.el ends here
