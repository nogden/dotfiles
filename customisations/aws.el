;; Emacs functions for interacting with AWS.

(defvar aws-credentials-file "~/.aws/credentials")
(defvar stscreds-executable "stscreds")

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

(defun load-env-vars (file-path)
  "Load an ini-like set of `key=value` pairs as environmental
   variables from `file-path`."
  (when (file-readable-p file-path)
      (mapc '(lambda (line)
               (let ((kv-pair (split-string line "=" t)))
                 (setenv (trim (car kv-pair)) (trim (car (cdr kv-pair))))))
            (cdr (read-lines aws-credentials-file)))))

(defun creds-process-sentinal (p e)
  (if (= 0 (process-exit-status p))
      (progn
        (load-env-vars aws-credentials-file)
        (message "Authenticated with AWS. Credentials loaded."))
    (message "AWS authentication failed! =(")))

(defun aws-authenticate (mfa-token)
  (interactive "NMFA Token: ")
  (let ((creds-process (start-process "creds-process" nil stscreds-executable "auth"))
        (mfa-string (concat (number-to-string mfa-token) "\n")))
    (set-process-sentinel creds-process 'creds-process-sentinal)
    (process-send-string "creds-process" mfa-string)))
