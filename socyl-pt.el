;;; socyl-pt.el --- Socyl backend which use pt

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

(defcustom socyl-pt-executable
  "pt"
  "Name of the pt executable to use."
  :type 'string
  :group 'socyl)


(defcustom socyl-pt-arguments
  (list "--smart-case")
  "Default arguments passed to pt."
  :type '(repeat (string))
  :group 'socyl)



(socyl--define-backend pt :search 'socyl--pt-regexp)


(defun socyl--pt-regexp (regexp directory &optional args)
  "Run a pt search with REGEXP rooted at DIRECTORY."
  (interactive (list (read-from-minibuffer "Pt search for: " (thing-at-point 'symbol))
                     (read-directory-name "Directory: ")))
  (let ((default-directory (file-name-as-directory directory)))
    (compilation-start
     (mapconcat 'identity
                (append (list socyl-pt-executable)
                        socyl-pt-arguments
                        args
                        '("-e" "--nogroup" "--color" "--")
                        (list (shell-quote-argument regexp) ".")) " ")
     'socyl-search-mode)))


(provide 'socyl-pt)
;;; socyl-pt.el ends here
