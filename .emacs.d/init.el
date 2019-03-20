;; Load variables set by the customize system
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; Ensure these packages are installed by default.
(defvar my-packages
  '(buffer-move
    cargo                 ;; Rust build integration
    cider
    clj-refactor
    clojure-mode
    clojure-mode-extra-font-locking
    company               ;; Auto-complete
    company-lsp
    company-math          ;; Latex symbol completion
    counsel               ;; Popup interface and swiper searching
    counsel-projectile
    fill-column-indicator ;; 80 character line
    highlight-thing       ;; Highlight matching symbols under point
    idea-darkula-theme
    latex-extra
    lsp-mode
    magit                 ;; Git integration
    magit-gh-pulls        ;; Github pull requests
    neotree
    org
    paredit
    projectile
    racer
    rainbow-delimiters
    rust-mode
    smart-mode-line
    smart-mode-line-powerline-theme
    smex                  ;; Show the most recent commands first
    tagedit               ;; Edit html tags like sexps
    toml-mode
    windmove))

;; Fix OS X weirdness when starting Emacs from a shell.
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
(add-to-list 'load-path "~/.emacs.d/vendor")

;; Find further customisations
(add-to-list 'load-path "~/.emacs.d/customisations")
(load "shell-integration.el")
(load "navigation.el")
(load "ui.el")
(load "editing.el")
(load "misc.el")
(load "elisp-editing.el")
(load "setup-clojure.el")
(load "setup-js.el")
(load "ruby.el")
(load "setup-rust.el")
(load "aws.el")
(put 'upcase-region 'disabled nil)
