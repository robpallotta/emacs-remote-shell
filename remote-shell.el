;;; remote-shell.el --- Open a remote shell buffer
;; Copyright (C) 2021 Rob Pallotta

;; Author: Rob Pallotta <rob@robpallotta.com>
;; Version: 1.0

;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Commentary:

;; Interactively open shell-mode buffer on remote machine, using
;; tramp.  Hostnames are autocompleted from ~/.shh/config.  Usernames
;; are autocompleted from `remote-shell-user-completion-list`.

;;; Code:

(require 'tramp)

(defgroup remote-shell nil "Connect to remote shells with tramp."
  :prefix "remote-shell"
  :group 'convenience)

(defcustom remote-shell-user-completion-list nil
  "List of usernames to use for completion."
  :type '(repeat string)
  :group 'remote-shell)

(defvar remote-shell--host-history nil)

(defvar remote-shell--user-history nil)

;;;###autoload
(defun remote-shell (host user)
  "Open a remote shell to HOST as USER."
  (interactive
   (list
    (completing-read "Host: " (seq-filter 'stringp (mapcar 'cadr (tramp-parse-sconfig "~/.ssh/config"))) nil nil nil 'remote-shell--host-history)
    (completing-read "User: " remote-shell-user-completion-list nil nil nil 'remote-shell--user-history)))
  (with-temp-buffer
    (let ((explicit-shell-file-name "bash")
          (explicit-bash-args (cons "--login" nil))
          (default-directory (concat "/ssh:" user "@" host ":")))
      (shell (generate-new-buffer-name (concat "*" host "*"))))))

(provide 'remote-shell)
;;; remote-shell.el ends here
