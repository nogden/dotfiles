;;;;
;; Clojure
;;;;

;; Enable paredit for Clojure
(add-hook 'clojure-mode-hook 'enable-paredit-mode)

;; Show documentation in status bar
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)

;; This is useful for working with camel-case tokens, like names of
;; Java classes (e.g. JavaClassName)
(add-hook 'clojure-mode-hook 'subword-mode)

;; A little more syntax highlighting
(require 'clojure-mode-extra-font-locking)

;; syntax highliting for midje
(add-hook 'clojure-mode-hook
          (lambda ()
            (setq inferior-lisp-program "lein repl")
            (font-lock-add-keywords
             nil
             '(("(\\(facts?\\)"
                (1 font-lock-keyword-face))
               ("(\\(background?\\)"
                (1 font-lock-keyword-face))))
            (define-clojure-indent (fact 1))
            (define-clojure-indent (facts 1))))


;; clj-refactor
(require 'clj-refactor)
(add-hook 'clojure-mode-hook
          (lambda ()
            (clj-refactor-mode 1)
            (yas-minor-mode 1)
            (cljr-add-keybindings-with-prefix "C-c r")))

;; Disable help banner on repl start-up.
(setq cider-repl-display-help-banner nil)

;; go right to the REPL buffer when it's finished connecting
;; (setq cider-repl-pop-to-buffer-on-connect t)

;; When there's a cider error, show its buffer and switch to it
(setq cider-show-error-buffer t)
(setq cider-auto-select-error-buffer t)

;; Try looking up the symbol at point first before prompting.
(setq cider-prompt-for-symbol nil)

;; Where to store the cider history.
(setq cider-repl-history-file "~/.emacs.d/cider-history")

;; Wrap when navigating history.
(setq cider-repl-wrap-history t)

;; enable paredit in your REPL
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; Shorten the Cider repl prompt
(setq cider-repl-prompt-function 'cider-repl-prompt-abbreviated)

;; Use clojure mode for other extensions
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))

(add-hook 'cider-mode-hook
          (lambda ()
            (global-set-key (kbd "<f2>")     'cider-find-var)
            (global-set-key (kbd "<f1>")     'cider-pop-back)
            (global-set-key (kbd "C-c C-n")  'cider-eval-ns-form)))
