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
  :straight nil
  :mode "\\.js$"
  :hook (js-mode . subword-mode)
  :config
  (setq js-indent-level 2))
