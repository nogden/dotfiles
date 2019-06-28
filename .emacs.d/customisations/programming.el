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
  :hook (rust-mode c-mode c++-mode)
  :commands lsp
  :bind (("C-c M-j" . lsp)))

(use-package company-lsp
  :after lsp-mode
  :commands company-lsp
  :init
  (push 'company-lsp company-backends))

;; C / C++
(use-package cc-mode
  :straight nil
  :bind (:map c++-mode-map
         ("C-c C-c" . run-build-script)
         ("<f2>"    . lsp-find-definition)
         ("<f1>"    . pop-tag-mark)))

;; Debugging support
(use-package gdb-mi
  :straight (:host github :repo "weirdNox/emacs-gdb" :files ("*.el" "*.c" "*.h" "Makefile"))
  :init
  (fmakunbound 'gdb)
  (fmakunbound 'gdb-enable-debug))

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
