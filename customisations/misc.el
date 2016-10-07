;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; No need for ~ files when editing
(setq create-lockfiles nil)

;; Go straight to scratch buffer on startup
(setq inhibit-startup-message t)

;; Enable auto saving and loading of Desktop sessions
(desktop-save-mode 1)

;; Auto-revert buffers if they change on disk
(global-auto-revert-mode t)

;; Rcirc settings
(setq rcirc-default-nick "nogden")
(setq rcirc-default-user-name "nick@nickogden.org")
(setq rcirc-default-full-name "Nick Ogden")
(setq rcirc-server-alist
      '(("irc.freenode.net" :channels ("#clojure"))))
(setq rcirc-authinfo
      '(("irc.freenode.net" nickserv "nogden" "acfre-4_3468")))
(add-hook 'rcirc-mode-hook
          (lambda ()
            (flyspell-mode 1)))

;; Magit options
(setq git-commit-summary-max-length 66)

(require 'magit-gh-pulls)
(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)

;; Control Spotify easily
(global-set-key (kbd "C-x p") 'spotify-playpause)
