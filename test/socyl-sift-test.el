;;; socyl-sift-test.el --- Tests for Socyl sift backend

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


(ert-deftest test-socyl-sift-backend ()
  :tags '(backend sift)
  (socyl-test-helper-with-test-sandbox
   ;; (message "All backends: %s" socyl-backends)
   (let ((socyl-backend 'sift))
     (should (equal 'sift (car (socyl--get-backend))))
     (should (equal 'socyl--sift-regexp (socyl-backend-search))))))



(provide 'socyl-sift-test)
;;; socyl-sift-test.el ends here
