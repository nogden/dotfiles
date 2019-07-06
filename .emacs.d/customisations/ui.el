;; Get rid of all distractions so we can focus on code
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq initial-scratch-message "Hi Nick. What will you create today?")
(setq-default frame-title-format "%b (%f)")  ;; Show full file path in titlebar
(fset 'yes-or-no-p 'y-or-n-p)                ;; Y or N to answer questions

;; Use UTF-8 everywhere
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-default-coding-systems 'utf-8-unix)
(setq-default buffer-file-coding-system 'utf-8-unix)
(setq-default default-buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(when (eq system-type 'windows-nt)  ;; Interop with windows clipboard
  (set-clipboard-coding-system 'utf-16le-dos))

;; Text
(setq-default cursor-type 'bar)
(blink-cursor-mode 0)
(set-default 'truncate-lines t)  ;; Don't line wrap
(show-paren-mode 1)              ;; Highlight matching parenthesis
(global-hl-line-mode 1)          ;; Highlight current line

;; Make identical buffer names unique
(setq uniquify-buffer-name-style 'forward)

(use-package base-keys
  :straight nil
  :init
  (global-set-key (kbd "H-g") (kbd "C-g"))
  (global-set-key (kbd "H-c") (kbd "C-c"))
  :bind (("H-h" . left-char)
         ("H-j" . next-line)
         ("H-k" . previous-line)
         ("H-l" . right-char)
         ("H-/" . swiper)
         ("H-a" . move-beginning-of-line)
         ("H-e" . move-end-of-line)
         ("H-u" . undo)
         ("H-s" . save-buffer)
         ("H-y" . yank)))

;; Load theme
(use-package idea-darkula-theme
  :init
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
  (add-to-list 'load-path "~/.emacs.d/themes")
  (load-theme 'idea-darkula t))

(use-package ivy
  :bind (:map ivy-minibuffer-map
         ("C-j" . ivy-immediate-done)
         ("RET" . ivy-alt-done))
  :init
  (ivy-mode 1)           ;; Use globally at startup
  :config
  (setq ivy-use-virtual-buffers t
        ivy-height 15
        ivy-count-format "(%d/%d) "
        ivy-extra-directories nil
        ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  :delight)

(use-package counsel
  :bind* (("M-x"       . counsel-M-x)
          ("C-s"       . swiper)
          ("C-x f"     . counsel-projectile-rg)
          ("C-x C-f"   . counsel-find-file)
          ("C-x C-g f" . counsel-git-grep)
          ("C-c g"     . counsel-git)
          ("C-c l"     . counsel-locate)
          ("C-c C-f"   . counsel-find-file)))

(use-package smart-mode-line
  :init
  (sml/setup)
  (sml/apply-theme 'respectful)
  :config
  (setq column-number-mode t))

(use-package company
  :config (global-company-mode))

(use-package windmove
  :config                   ;; Allow navigating between splits with super key
  (windmove-default-keybindings 'super)
  :bind (("H-w H-h" . windmove-left)
         ("H-w H-j" . windmove-down)
         ("H-w H-k" . windmove-up)
         ("H-w H-l" . windmove-right)))

;; Easy buffer movement
(use-package buffer-move
  :bind (("<C-s-up>"    . buf-move-up)
         ("<C-s-down>"  . buf-move-down)
         ("<C-s-left>"  . buf-move-left)
         ("<C-s-right>" . buf-move-right)))

(use-package ibuffer
  :bind (("C-x C-b" . ibuffer)))

(use-package treemacs
  :commands treemacs
  :bind ("C-x t" . treemacs))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package treemacs-magit
  :after (treemacs magit))

;; Make C-x +/-/0 zoom frames, not buffers
(use-package zoom-frm
  :bind (:map ctl-x-map
         ([(control ?+)] . zoom-in/out)
         ([(control ?-)] . zoom-in/out)
         ([(control ?=)] . zoom-in/out)
         ([(control ?0)] . zoom-in/out)))

;; A function for dedicating windows to buffers
(defun toggle-window-dedicated ()
  "Control whether or not Emacs is allowed to display another
   buffer in current window."
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window (not (window-dedicated-p window))))
       "%s: Can't touch this!"
     "%s is up for grabs.")
   (current-buffer)))

(global-set-key (kbd "C-x w") 'toggle-window-dedicated)

;; Switch between HiDPI and non HiDPI mode
(defun hidpi-mode ()
  (interactive)
  (if (> 120 (face-attribute 'default :height (selected-frame)))
    (set-face-attribute 'default (selected-frame) :height 130)
    (set-face-attribute 'default (selected-frame) :height 93)))
