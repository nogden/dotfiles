;; Sets up exec-path-from shell
;; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH")))

(defun read-lines (path)
  (with-temp-buffer
    (insert-file-contents path)
    (split-string (buffer-string) "\n" t)))

(defun trim (str)
      "Trim leading and tailing whitespace from str."
      (replace-regexp-in-string (rx (or (: bos (* (any " \t\n")))
                                        (: (* (any " \t\n")) eos)))
                                ""
                                str))

(defvar aws-credentials-file "~/.aws/credentials")

;; Set AWS environemnt variables for debugging within Emacs
(defun aws-load-credentials ()
  (interactive)
  (if (file-readable-p aws-credentials-file)
      (progn
        (mapc '(lambda (line)
                 (let ((kv-pair (split-string line "=" t)))
                   (setenv (trim (car kv-pair)) (trim (car (cdr kv-pair))))))
              (cdr (read-lines aws-credentials-file)))
        (message "Credentials loaded"))
    (message (concat "Failed. '" aws-credentials-file "' not found."))))
