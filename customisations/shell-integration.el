;; Sets up exec-path-from shell
;; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH")))

;; Set AWS environemnt variables for debugging within Emacs
(defun read-lines (path)
  (with-temp-buffer
    (insert-file-contents path)
    (split-string (buffer-string) "\n" t)))

(mapc '(lambda (line)
         (let ((kv-pair (split-string line "=" t)))
           (setenv (car kv-pair) (car (cdr kv-pair)))))
      (cdr (read-lines "~/.aws/credentials")))
