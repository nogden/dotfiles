;; Settings to make editing Ruby code nicer
(require 'flymake-ruby)
(require 'robe)

;; Syntax checking
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; Sane parameter indenting
(setq ruby-deep-indent-paren nil)

;; Navigation
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "<f2>") 'robe-jump)
            (local-set-key (kbd "<f1>") 'xref-pop-marker-stack)))
