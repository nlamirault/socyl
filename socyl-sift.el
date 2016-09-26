;;; socyl-sift.el --- Socyl backend which use sift

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
;; 02110-1301, USA.

;;; Commentary:

;;; Code:


(require 'socyl-custom)
(require 'socyl-backend)
(require 'socyl-mode)



;; Customization
;; --------------------------


(defcustom socyl-sift-executable
  "sift"
  "Name of the sift executable to use."
  :type 'string
  :group 'socyl)


(defcustom socyl-sift-arguments
  (list "-I")
  "Default arguments passed to sift."
  :type '(repeat (string))
  :group 'socyl)


(socyl--define-backend sift :search 'socyl--sift-regexp)


;;;###autoload
(defun socyl--sift-regexp (regexp directory &optional args)
  "Run a sift search with `REGEXP' rooted at `DIRECTORY'.
`ARGS' provides Sift command line arguments."
  (interactive
   (list (read-from-minibuffer "Sift search for: " (thing-at-point 'symbol))
         (read-directory-name "Directory: ")))
  (let ((default-directory directory))
    (compilation-start
     (mapconcat 'identity
                (append (list socyl-sift-executable)
                        socyl-sift-arguments
                        args
                        '("--color" "-n" "--stats")
                        (list (shell-quote-argument regexp) ".")) " ")
     'socyl-search-mode)))


(provide 'socyl-sift)
;;; socyl-sift.el ends here
