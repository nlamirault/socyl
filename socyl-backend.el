;;; socyl-backend.el --- Socyl backend

;; Copyright (C) 2016, 2017 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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


(require 'cl-lib)


(defvar socyl-backends '()
  "List of available search backends.")


(defvar socyl-backend nil
  "The currently search backend.")

(defmacro socyl--define-backend (name &rest options)
  "Macro which define a new search backend.
`NAME' is for display
`OPTIONS' specify backend arguments."
  (let* ((search (plist-get options :search)))
    `(progn
       (add-to-list 'socyl-backends
                    (cons ',name
                          (list (cons 'search ,search)))))))


(defun socyl--get-backend ()
  "Search for search backene"
  (assoc socyl-backend socyl-backends))


(defmacro socyl--with-backend (backend &rest body)
  `(if socyl-backend
       (progn
         (let ((,backend (socyl--get-backend)))
           (if (null (cdr ,backend))
               (message "Socyl: error with backend: %s=%s" socyl-backend backend)
             ,@body)))
     (message "Socyl: no backend specify.")))


(defun socyl-backend-search ()
  (socyl--with-backend backend
    (cl-cdadr backend)))


(defun socyl-search-regexp (regexp directory &optional args)
  (socyl--with-backend backend
    (funcall (cl-cdadr backend) regexp directory args)))


(provide 'socyl-backend)
;;; socyl-backend.el ends here
