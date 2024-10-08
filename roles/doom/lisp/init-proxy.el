;;; init-proxy --- proxy only -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defun show-proxy ()
  "Show http/https proxy."
  (interactive)
  (message "http_proxy=>\"%s\" https_proxy=>\"%s\" no_proxy=>\"%s\""
           (getenv "HTTP_PROXY")
           (getenv "HTTPS_PROXY")
           (getenv "NO_PROXY")))

(provide 'init-proxy)
;;; init-proxy.el ends here
