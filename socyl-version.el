;;; socyl-version.el --- Socyl  version

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

(require 'dash)
(require 'pkg-info)
(require 's)


(defun socyl--library-version ()
  "Get the version in the socyl library."
  (-when-let (version (pkg-info-library-version 'socyl))
    (pkg-info-format-version version)))


;;;###autoload
(defun socyl-version (&optional show-version)
  "Get the socyl version as string.
If called interactively or if SHOW-VERSION is non-nil, show the
version in the echo area and the messages buffer.
The returned string includes both, the version from package.el
and the library version, if both a present and different.
If the version number could not be determined, signal an error,
if called interactively, or if SHOW-VERSION is non-nil, otherwise
just return nil."
  (interactive (list (not (or executing-kbd-macro noninteractive))))
  (let* ((version (socyl--library-version)))
    (unless version
      (error "Could not find out socyl version"))
    (message "socyl %s" version)
    version))


(provide 'socyl-version)
;;; socyl-version.el ends here
