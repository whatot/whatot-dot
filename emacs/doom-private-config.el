
;;; basic part
(setq doom-font (font-spec
                 :family "Source Code Pro"
                 :size (cond
                        ((string= (system-name) "x411") '19)
                        ((string= (system-name) "b150") '30)
                        ((string= system-type "darwin") '13))))
(setq frame-title-format
          '(buffer-file-name "%f [%m]"
            (dired-directory dired-directory "%b")))

(provide 'doom-private-config)
;;; doom-private-config.el ends here
