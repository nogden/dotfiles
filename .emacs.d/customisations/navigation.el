;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.


;; "When several buffers visit identically-named files,
;; Emacs must give the buffers distinct names. The usual method
;; for making buffer names unique adds ‘<2>’, ‘<3>’, etc. to the end
;; of the buffer names (all but one of them).
;; The forward naming method includes part of the file's directory
;; name at the beginning of the buffer name
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Turn on recent file mode so that you can more easily switch to
;; recently edited files when you first start emacs
(setq recentf-save-file (concat user-emacs-directory ".recentf"))
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 40)

;; Ivy

(ivy-mode 1)

(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(setq ivy-extra-directories nil)
(global-set-key (kbd "M-x") 'counsel-M-x)

;; Use C-j for immediate termination with the current value, RET
;; for continuing completion for that directory, This is the ido
;; behaviour.
(define-key ivy-minibuffer-map (kbd "C-j") #'ivy-immediate-done)
(define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)

;; Search with swiper by default
(global-set-key (kbd "C-s") 'swiper)

;; Shows a list of buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Allow navigating between splits with win-<up> / win-<left> etc
(windmove-default-keybindings 'super)

;; projectile everywhere!
(projectile-global-mode)
(counsel-projectile-mode)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Use counsel-projectile's ripgrep and git search easily
(global-set-key (kbd "C-x f") 'counsel-projectile-rg)
(global-set-key (kbd "C-x C-g f") 'counsel-git-grep)

;; Neotree setup
(global-set-key (kbd "C-x t") 'neotree-toggle)

;; Show Magit status buffer
(global-set-key (kbd "C-x g") 'magit-status)
