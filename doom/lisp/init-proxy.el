;;; init-proxy --- proxy only -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defvar url-proxy-services)

(defvar my-proxy (string-replace "http://" "" (getenv "HTTP_PROXY")))

(defun show-proxy ()
  "Show http/https proxy."
  (interactive)
  (if url-proxy-services
      (message "Current proxy is \"%s\"" my-proxy)
    (message "No proxy")))

(defun set-proxy ()
  "Set http/https proxy."
  (interactive)
  (setq url-proxy-services
        '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
          ("http" . my-proxy)
          ("https" . my-proxy)))
  (show-proxy))

(defun unset-proxy ()
  "Unset http/https proxy."
  (interactive)
  (setq url-proxy-services nil)
  (show-proxy))

(defun toggle-proxy ()
  "Toggle http/https proxy."
  (interactive)
  (if url-proxy-services
      (unset-proxy)
    (set-proxy)))

(set-proxy)

(provide 'init-proxy)
;;; init-proxy.el ends here
