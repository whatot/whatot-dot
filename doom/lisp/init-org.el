;;; init-org --- config org with plugins -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defvar org-roam-directory)
(defvar org-roam-dailies-capture-templates)

(setq org-roam-directory
      (if (string= (system-name) "star")
          (file-truename "~/roam")
        (file-truename "~/nutstore/thoughts/roam")))

(provide 'init-org)
;;; init-org.el ends here
