;; Settings to make editing Ruby code nicer
(require 'flymake-ruby)

;; Syntax checking
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; Sane parameter indenting
(setq ruby-deep-indent-paren nil)
