;;; init-roam --- config roam2 -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defvar org-roam-directory)
(defvar org-roam-dailies-capture-templates)

(setq org-roam-directory
      (if (string= (system-name) "star")
          (file-truename "~/roam")
        (file-truename "~/nutstore/thoughts/roam")))

(setq org-roam-dailies-capture-templates
      (let ((head "#+title: %<%Y-%m-%d (%A)>\n#+startup: showall\n* [/] Do Today\n* [/] Maybe Do Today\n* Journal\n"))
        `(("j" "journal" entry
           #'org-roam-capture--get-point
           "* %<%H:%M> %?"
           :file-name "daily/%<%Y-%m-%d>"
           :head ,head
           :olp ("Journal"))
          ("t" "do today" item
           #'org-roam-capture--get-point
           "[ ] %(princ as/agenda-captured-link)"
           :file-name "daily/%<%Y-%m-%d>"
           :head ,head
           :olp ("Do Today")
           :immediate-finish t)
          ("m" "maybe do today" item
           #'org-roam-capture--get-point
           "[ ] %(princ as/agenda-captured-link)"
           :file-name "daily/%<%Y-%m-%d>"
           :head ,head
           :olp ("Maybe Do Today")
           :immediate-finish t))))

(provide 'init-roam)
;;; init-roam.el ends here
