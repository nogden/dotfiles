;; General programming configuration

;; Show line numbers and the 80 character line when programming
(use-package fill-column-indicator
  :hook ((prog-mode . fci-mode)
         (prog-mode . linum-mode))
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

;; Project navigationlo
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

;; Git
(use-package magit
  :bind (("C-x g" . magit-status))
  :config
  (setq git-commit-summary-max-length 66))

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
  :hook rust-mode)

(use-package company-lsp
  :init
  (push 'company-lsp company-backends))
