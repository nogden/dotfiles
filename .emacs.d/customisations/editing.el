;; Customizations relating to editing a buffer.

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
