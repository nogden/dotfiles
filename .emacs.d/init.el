;; Trade memory usage for startup speed
(setq gc-cons-threshold 100000000)

;; Load variables set by the customize system
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Package installation
(require 'package)
(setq package-enable-at-startup nil) ; Wait until we setup use-package
(setq package-archives
      '(("gnu"          . "http://elpa.gnu.org/packages/")
;;      ("marmalade"    . "http://marmalade-repo.org/packages/")
;;      ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa"        . "https://melpa.org/packages/")))

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before we start trying to modify them.  This
;; also sets the load path.
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)  ; Install packages if needed

;; Ensure we have the same env vars as the shell
(use-package exec-path-from-shell
  :when (memq window-system '(mac ns x))
  :config
  (setq exec-path-from-shell-arguments nil)
  (exec-path-from-shell-initialize))

(add-to-list 'load-path "vendor")

;; UI

;; Get rid of all distractions so we can focus on code
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)
(setq inhibit-startup-screen  t
      inhibit-startup-message t
      ring-bell-function      'ignore
      initial-scratch-message "Hi Nick. What will you create today?")
(setq-default frame-title-format "%b (%f)")  ;; Show full file path in titlebar
(fset 'yes-or-no-p 'y-or-n-p)                ;; Y or N to answer questions

;; Use UTF-8 everywhere
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-default-coding-systems 'utf-8-unix)
(setq-default buffer-file-coding-system 'utf-8-unix)
(setq-default default-buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(when (eq system-type 'windows-nt)  ;; Interop with windows clipboard
  (set-clipboard-coding-system 'utf-16le-dos))

;; Text
(setq-default cursor-type 'bar)
(blink-cursor-mode 0)
(set-default 'truncate-lines t)  ;; Don't line wrap
(show-paren-mode 1)              ;; Highlight matching parenthesis
(global-hl-line-mode 1)          ;; Highlight current line

;; Make identical buffer names unique
(setq uniquify-buffer-name-style 'forward)

;; Load theme
(use-package idea-darkula-theme
  :init
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
  (add-to-list 'load-path "~/.emacs.d/themes")
  (load-theme 'idea-darkula t))

(use-package ivy
  :bind (:map ivy-minibuffer-map
         ("C-j" . ivy-immediate-done)
         ("RET" . ivy-alt-done))
  :init
  (ivy-mode 1)           ;; Use globally at startup
  :config
  (setq ivy-use-virtual-buffers t
        ivy-height 15
        ivy-count-format "(%d/%d) "
        ivy-extra-directories nil
        ivy-re-builders-alist '((t . ivy--regex-plus))))

(use-package counsel
  :commands swiper
  :bind* (("M-x"       . counsel-M-x)
          ("C-s"       . swiper)
          ("C-x f"     . counsel-projectile-rg)
          ("C-x C-f"   . counsel-find-file)
          ("C-x C-g f" . counsel-git-grep)
          ("C-c g"     . counsel-git)
          ("C-c l"     . counsel-locate)
          ("C-c C-f"   . counsel-find-file)))

(use-package ryo-modal
  :commands ryo-modal-mode
  :hook (prog-mode . ryo-modal-mode)
  :bind ("<escape>" . ryo-modal-mode)
  :config
  (setq ryo-modal-cursor-color "#A9B7C6")
  (ryo-modal-keys
   ("<escape>" keyboard-quit)
   ("i"        ryo-modal-mode)
   ("h"        left-char)
   ("j"        next-line)
   ("k"        previous-line)
   ("l"        right-char)
   ("a" (("h"  move-beginning-of-line)
         ("l"  move-end-of-line)
         ("j"  scroll-up)
         ("k"  scroll-down)))
   ("u"        undo)
   ("/"        swiper)
   ("s"        save-buffer)
   ("r r"      query-replace)))

(use-package expand-region
  :ryo
  ("e" er/expand-region)
  ("r" (("w" er/mark-word     :name "Replace word")
        ("s" er/mark-sentence :name "Replace sentence")
        ("c" er/mark-defun    :name "Replace function"))
   :then '(kill-region) :exit t))

(use-package anzu
  :config (global-anzu-mode 1)
  :bind (("C-r"   . anzu-query-replace-at-cursor)
         ("C-x r" . anzu-query-replace-regexp)))

(use-package smart-mode-line
  :init
  (setq sml/theme          'respectful
        column-number-mode t)
  (sml/setup))

(use-package company
  :defer t
  :config
  (setq company-minimum-prefix-length     1
        company-idle-delay                0.0
        company-tooltip-align-annotations t)
  (global-company-mode))

(use-package windmove
  :bind (("<s-up>"    . windmove-up)
         ("<s-down>"  . windmove-down)
         ("<s-left>"  . windmove-left)
         ("<s-right>" . windmove-right))
  :ryo
  ("w" (("h" windmove-left)
        ("j" windmove-down)
        ("k" windmove-up)
        ("l" windmove-right)
        ("0" delete-window)
        ("1" delete-other-windows)
        ("2" split-window-below)
        ("3" split-window-right))))

;; Easy buffer movement
(use-package buffer-move
  :bind (("<C-s-up>"    . buf-move-up)
         ("<C-s-down>"  . buf-move-down)
         ("<C-s-left>"  . buf-move-left)
         ("<C-s-right>" . buf-move-right)))

(use-package ibuffer
  :bind (("C-x C-b" . ibuffer)))

(use-package treemacs
  :commands treemacs
  :bind ("C-x t" . treemacs))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package treemacs-magit
  :after (treemacs magit))

;; Make C-x +/-/0 zoom frames, not buffers
(use-package zoom-frm
  :ensure nil
  :bind (:map ctl-x-map
         ([(control ?+)] . zoom-in/out)
         ([(control ?-)] . zoom-in/out)
         ([(control ?=)] . zoom-in/out)
         ([(control ?0)] . zoom-in/out)))

;; A function for dedicating windows to buffers
(defun toggle-window-dedicated ()
  "Control whether or not Emacs is allowed to display another
   buffer in current window."
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window (not (window-dedicated-p window))))
       "%s: Can't touch this!"
     "%s is up for grabs.")
   (current-buffer)))

(global-set-key (kbd "C-x w") 'toggle-window-dedicated)

;; Switch between HiDPI and non HiDPI mode
(defun hidpi-mode ()
  (interactive)
  (if (> 120 (face-attribute 'default :height (selected-frame)))
    (set-face-attribute 'default (selected-frame) :height 130)
    (set-face-attribute 'default (selected-frame) :height 93)))

;; Editing

;; Clipboard and mouse interactions
(setq x-select-enable-clipboard           t
      x-select-enable-primary             t
      save-interprogram-paste-before-kill t  ;; Don't loose clipboard on yank
      apropos-do-all                      t
      mouse-yank-at-point                 t)

(delete-selection-mode 1)               ;; Overwrite selected text when typing.
(setq-default indent-tabs-mode nil)     ;; Don't use hard tabs
(add-hook 'before-save-hook
          'delete-trailing-whitespace)  ;; Delete trailing whitespace on save
(setq electric-indent-mode 1)           ;; Enter performs auto-indent
(setq-default sh-basic-offset 2)
(setq-default sh-indentation  2)

;; Put backups in ~/.emacs.d/backups.
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
(setq auto-save-default nil)
(setq create-lockfiles nil)             ;; Turn off ~ files
(global-auto-revert-mode t)             ;; Reload buffers that change on disk

;; Key bindings
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)  ;; Comments
(global-set-key (kbd "C-c m") 'set-rectangular-region-anchor) ;; Multiple cursors

(desktop-save-mode 1)

;; Temporary
(use-package esup
  :ensure t
  :init
  (setq esup-depth 0)
  :pin melpa
  :commands (esup))

;; Easy switching to recently edited files
(use-package recentf
  :init
  (setq recentf-save-file      (concat user-emacs-directory ".recentf")
        recentf-max-menu-items 40)
  :config
  (recentf-mode 1))

;; Return in a buffer to where we left off
(use-package saveplace
  :config
  (setq-default save-place t)
  ;; keep track of saved places in ~/.emacs.d/places
  (setq save-place-file (concat user-emacs-directory "places")))

;; Use 2 spaces for tabs
(defun tabs-2-spaces ()
  "Replace all tabs in the buffer with two spaces."
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))

(use-package org
  :ensure nil
  :defer t
  :config
  (setq org-default-notes-file (concat org-directory "/notes.org")
        org-startup-indented   t))

;; Programming

;; Show line numbers and the 80 character line when programming
(use-package fill-column-indicator
  :hook (prog-mode . fci-mode)
        (prog-mode . display-line-numbers-mode)
  :config
  (setq fci-rule-column 80)
  (setq fci-rule-color "gray28"))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Highlight symbol under point
(use-package highlight-thing
  :hook (prog-mode . highlight-thing-mode)
  :config
  (setq highlight-thing-delay-seconds 0.1)
  (setq highlight-thing-case-sensitive-p t)
  :custom-face
  (hi-yellow ((t (:background "gray28")))))

;; Project navigation
(use-package projectile
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (projectile-global-mode))

(use-package counsel-projectile
  :after (counsel projectile)
  :bind (("C-x f" . counsel-projectile-rg))
  :config
  (counsel-projectile-mode))

(use-package eldoc
  :hook ((emacs-lisp-mode
          lisp-interaction-mode
          ielm-mode
          cider-mode) . eldoc-mode))

(use-package flycheck
  :init
  (global-flycheck-mode))

;; Git
(use-package magit
  :bind (("C-x g" . magit-status))
  :config
  (setq git-commit-summary-max-length 66))

(use-package forge
  :after magit)

;; Lisp
(use-package paredit
  :hook ((emacs-lisp-mode
          eval-expression-minibuffer-setup
          ielm-mode
          lisp-mode
          lisp-interaction-mode
          scheme-mode
          clojure-mode
          clojure-repl-mode
          cider-repl-mode) . paredit-mode))

;; LaTeX
(setq-default TeX-engine 'luatex)

(use-package latex-extra
  :hook LaTeX-mode-hook)

;; LSP support
(use-package lsp-mode
  :hook (c-mode c++-mode rust-mode)
  :commands lsp
  :bind (("C-c M-j" . lsp)
         ("<f2>"    . lsp-find-definition)
         ("<f1>"    . pop-tag-mark)
         ("C-c d"   . lsp-describe-thing-at-point))
  :init
  (setq lsp-rust-server                  'rust-analyzer
        lsp-signature-auto-activate      t
        lsp-modeline-diagnostics-enable  t
        lsp-modeline-code-actions-enable t))

(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol
  :bind (("C-c f s" . lsp-ivy-workspace-symbol)))

(use-package lsp-treemacs
  :bind (("C-c f r" . lsp-treemacs-references)
         ("C-c c h" . lsp-treemacs-call-hierarchy)))

;; C / C++
(use-package cc-mode
  :ensure nil
  :bind (:map c++-mode-map
         ("C-c C-c" . run-build-script)))

(defun file-search-upward (directory file)
  "Search DIRECTORY for FILE and return its full path if found, or NIL if not.

   If FILE is not found in DIRECTORY, the parent of DIRECTORY will be searched."
  (let ((parent-dir (file-truename (concat (file-name-directory directory) "../")))
        (current-path (if (not (string= (substring directory (- (length directory) 1)) "/"))
                          (concat directory "/" file)
                        (concat directory file))))
    (if (file-exists-p current-path)
        current-path
      (when (and (not (string= (file-truename directory) parent-dir))
                 (< (length parent-dir) (length (file-truename directory))))
        (file-search-upward parent-dir file)))))

;; Handmade hero build script
(defun run-build-script ()
  (interactive)
  (let* ((build-script      (file-search-upward "." "build.sh"))
         (default-directory (file-name-directory build-script)))
    (compile build-script))
  (other-window 1))

;; Python
(use-package elpy
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

;; Clojure
(use-package clojure-mode
  :mode ("\\.edn$" "\\.boot$")
  :init
  (add-hook 'clojure-mode-hook 'subword-mode)) ;; Easy working with Java tokens

;; A little more syntax highlighting
(use-package clojure-mode-extra-font-locking
  :after clojure-mode)

(use-package clj-refactor
  :hook (clojure-mode . clj-refactor-mode)
  :init
  (setq cljr-clojure-test-declaration "[clojure.test :refer :all]")
  :config
  (clj-refactor-mode 1)
  (yas-minor-mode 1)
  (cljr-add-keybindings-with-prefix "C-c C-r"))

(use-package cider
  :bind (:map cider-mode-map
         ("<f2>"    . cider-find-var)
         ("<f1>"    . cider-pop-back)
         ("C-c C-n" . cider-eval-ns-form))
  :ryo
  (:mode 'cider-mode :norepeat t)
  ("a" (("f"   cider-find-var)
        ("d"   cider-pop-back)))
  ("c" (("c" cider-eval-defun-at-point)
        ("n" cider-eval-ns-form)))
  :init
  (setq cider-repl-display-help-banner      nil
        cider-repl-pop-to-buffer-on-connect 'display-only
        cider-show-error-buffer             t
        cider-auto-select-error-buffer      t
        cider-prompt-for-symbol             nil  ;; Look up symbol at point first
        cider-repl-history-file             "~/.emacs.d/cider-history"
        cider-repl-wrap-history             t
        cider-repl-prompt-function          'cider-repl-prompt-abbreviated
        cider-clojure-cli-global-options    "-A:dev"
        cider-cljs-lein-repl                "(do (require 'figwheel-sidecar.repl-api)
                                             (figwheel-sidecar.repl-api/start-figwheel!)
                                             (figwheel-sidecar.repl-api/cljs-repl))"))

;; Rust
(use-package rust-mode
  :hook (rust-mode . electric-pair-mode)
  :bind (("C-;"         . comment-line)))

(use-package cargo
  :hook (rust-mode . cargo-minor-mode)
  :ryo
  (:mode 'cargo-minor-mode :norepeat t)
  ("c" (("b" cargo-process-build)
        ("t" cargo-process-test)
        ("c" cargo-process-check))))

(use-package toml-mode)

;; Go
(use-package go-mode
  :bind (:map go-mode-map
              ("<f2>" . godef-jump)
              ("<f1>" . pop-tag-mark)))

;; HTML / Javascript / CSS
(use-package mhtml-mode
  :hook (sgml-mode . subword-mode))

(use-package tagedit
  :hook (sgml-mode . tagedit-mode)
  :config
  (tagedit-add-paredit-like-keybindings))

(use-package emmet-mode
  :hook (sgml-mode css-mode))

(use-package js-mode
  :ensure nil
  :mode "\\.js$"
  :hook (js-mode . subword-mode)
  :config
  (setq js-indent-level 2))
