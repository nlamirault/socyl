;; socyl-test-socyl.el --- Test helpers for socyl.el

;; Copyright (C) 2016, 2017 Nicolas Lamirault <nicolas.lamirault@gmail.com>

;; Author: Nicolas Lamirault <nicolas.lamirault@gmail.com>
;; Homepage: https://github.com/nlamirault/socyl.el

;;; License:

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'ansi)
(require 'cl) ;; http://emacs.stackexchange.com/questions/2864/symbols-function-definition-is-void-cl-macroexpand-all-when-trying-to-instal
(require 'ert)
(require 'f)
(require 'undercover)

(setq debugger-batch-max-lines (+ 50 max-lisp-eval-depth)
      debug-on-error t)

(defvar socyl-test-helper-scame--username (getenv "HOME"))

(defconst socyl-testsuite-dir
  (f-parent (f-this-file))
  "The testsuite directory.")

(defconst socyl-source-dir
  (f-parent socyl-testsuite-dir)
  "The socyl.el source directory.")

(defconst socyl-sandbox-path
  (f-expand "sandbox" socyl-testsuite-dir)
  "The sandbox path for socyl.")

(defun socyl-test-helper--cleanup-load-path ()
  "Remove home directory from 'load-path."
  (message (ansi-green "[socyl] Cleanup path"))
  (mapc #'(lambda (path)
            (when (string-match (s-concat socyl-test-helper-scame--username "/.emacs.d") path)
              (message (ansi-yellow "Suppression path %s" path))
              (setq load-path (delete path load-path))))
        load-path)
  (add-to-list 'load-path socyl-source-dir))

(defun socyl-test-helper--load-unit-tests (path)
  "Load all unit test from PATH."
  (message (ansi-green "[socyl] Execute unit tests %s"
                       path))
  (dolist (test-file (or argv (directory-files path t "-test.el$")))
    (load test-file nil t)))


(defun socyl-test-helper--load-library (file)
  "Load current library from FILE."
  (let ((path (s-concat socyl-source-dir file)))
    (message (ansi-yellow "[socyl] Load library from %s" path))
    (undercover "*.el" (:exclude "*-test.el"))
    (require 'socyl path)))


(defmacro socyl-test-helper-with-test-sandbox (&rest body)
  "Evaluate BODY in an empty sandbox directory."
  `(unwind-protect
       (condition-case nil ;ex
           (let ((default-directory socyl-source-dir))
             (socyl-test-helper--cleanup-load-path)
             (socyl-test-helper--load-library "/socyl.el")
             ,@body))))


(provide 'socyl-test-helper)
;;; socyl-test-helper.el ends here
