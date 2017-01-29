;;; socyl-ripgrep.el --- Socyl backend which use Ripgrep
;;
;; Copyright (C) 2016, 2017 Nicolas Lamirault <nicolas.lamirault@gmail.com>
;;
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


(defcustom socyl-ripgrep-executable
  "rg"
  "Name of the ripgrep executable to use."
  :type 'string
  :group 'socyl)


(defcustom socyl-ripgrep-arguments
  (list "")
  "Default arguments passed to ripgrep."
  :type '(repeat (string))
  :group 'socyl)


(socyl--define-backend ripgrep :search 'socyl--ripgrep-regexp)


;;;###autoload
(defun socyl--ripgrep-regexp (regexp directory &optional args)
(interactive
   (list (read-from-minibuffer "Ripgrep search for: " (thing-at-point 'symbol))
         (read-directory-name "Directory: ")))
  (let ((default-directory directory))
    (compilation-start
     (mapconcat 'identity
                (append (list socyl-ripgrep-executable)
                        socyl-ripgrep-arguments
                        args
                        '("--no-heading")
                        (list (shell-quote-argument regexp) ".")) " ")
     'ripgrep-search-mode)))

(provide 'socyl-ripgrep)
;;; socyl-ripgrep.el ends here
