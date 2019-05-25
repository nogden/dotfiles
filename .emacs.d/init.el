;; Load variables set by the customize system
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Setup straight package management
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Use straight package management from use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Ensure we have the same env vars as the shell in OS X
(use-package exec-path-from-shell
  :when (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH")))

;; Find further customisations
(add-to-list 'load-path "~/.emacs.d/customisations")
(load "ui.el")
(load "editing.el")
(load "programming.el")
(load "clojure.el")
(load "web.el")
(load "rust.el")
(load "misc.el")
