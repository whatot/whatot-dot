
;;; basic part
(setq doom-font (font-spec
                 :family "Source Code Pro"
                 :size (cond
                        ((string= (system-name) "x411") '19)
                        ((string= (system-name) "b150") '30)
                        ((string= system-type "darwin") '13))))

(provide 'doom-config)
;;; doom-config.el ends here
