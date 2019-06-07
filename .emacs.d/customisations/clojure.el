;; Clojure
(use-package clojure-mode
  :mode ("\\.edn$" "\\.boot$")
  :init
  (add-hook 'clojure-mode-hook 'subword-mode)) ;; Easy working with Java tokens

;; A little more syntax highlighting
(use-package clojure-mode-extra-font-locking
  :after clojure-mode)

;; clj-refactor
(use-package clj-refactor
  :hook (clojure-mode . clj-refactor-mode)
  :init
  (setq cljr-clojure-test-declaration "[clojure.test :refer :all]")
  :config
  (clj-refactor-mode 1)
  (yas-minor-mode 1)
  (cljr-add-keybindings-with-prefix "C-c C-r"))

;; Cider
(use-package cider
  :bind (:map cider-mode-map
         ("<f2>"    . cider-find-var)
         ("<f1>"    . cider-pop-back)
         ("C-c C-n" . cider-eval-ns-form))
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
