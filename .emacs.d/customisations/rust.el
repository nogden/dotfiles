;; Rust support

(use-package rust-mode
  :hook (rust-mode . electric-pair-mode)
  :bind (("C-;"         . comment-line)))

(use-package racer
  :hook ((rust-mode  . racer-mode)
         (racer-mode . eldoc-mode))
  :bind (:map racer-mode-map
         ("<f2>"        . racer-find-definition)
         ("<f1>"        . pop-tag-mark)
         ("C-c C-d C-d" . racer-describe))
  :ryo
  ("f" racer-find-definition)
  ("d" pop-tag-mark))

(use-package cargo
  :hook (rust-mode . cargo-minor-mode)
  :ryo
  (:mode 'cargo-minor-mode :norepeat t)
  ("c" (("b" cargo-process-build)
        ("t" cargo-process-test)
        ("c" cargo-process-check))))

(use-package toml-mode)
