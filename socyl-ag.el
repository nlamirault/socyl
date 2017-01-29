;;; socyl-ag.el --- Socyl backend which use Ag
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


(defcustom socyl-ag-executable
  "ag"
  "Name of the ag (The Silver Searcher) executable to use."
  :type 'string
  :group 'socyl)


(defcustom socyl-ag-arguments
  (list "--smart-case" "--stats")
  "Default arguments passed to ag."
  :type '(repeat (string))
  :group 'socyl)


(socyl--define-backend ag :search 'socyl--ag-regexp)


;;;###autoload
(defun socyl--ag-regexp (regexp directory &optional args)
  (interactive
   (list (read-from-minibuffer "Ag search for: " (thing-at-point 'symbol))
         (read-directory-name "Directory: ")))
  (let ((default-directory directory))
    (compilation-start
     (mapconcat 'identity
                (append (list socyl-ag-executable)
                        socyl-ag-arguments
                        args
                        '("-0" "--line-number" "--column" "--stats" "--color")
                        (list (shell-quote-argument regexp) ".")) " ")
     'socyl-search-mode)))


(provide 'socyl-ag)
;;; socyl-ag.el ends here
