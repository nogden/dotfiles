;; Enable cargo mode in rust mode
(add-hook 'rust-mode-hook 'cargo-minor-mode)

;; Auto-insert closing brackets
(add-hook 'rust-mode-hook 'electric-pair-mode)

;; Run rustfmt on C-<tab>
(add-hook 'rust-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))
