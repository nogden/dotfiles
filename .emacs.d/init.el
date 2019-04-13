;; Load variables set by the customize system
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Define package repositories
(require 'package)
(setq package-enable-at-startup nil) ; Wait until we setup use-package

(setq package-archives
      '(("gnu"          . "http://elpa.gnu.org/packages/")
        ("marmalade"    . "http://marmalade-repo.org/packages/")
;;      ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa"        . "https://melpa.org/packages/")))

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)  ;; Install packages if needed

;; Ensure we have the same env vars as the shell in OS X
(use-package exec-path-from-shell
  :when (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH")))

;; Load manual elisp files from the vendor directory
(add-to-list 'load-path "~/.emacs.d/vendor")

;; Find further customisations
(add-to-list 'load-path "~/.emacs.d/customisations")
(load "ui.el")
(load "editing.el")
(load "programming.el")
(load "clojure.el")
(load "web.el")
(load "rust.el")
(load "misc.el")
