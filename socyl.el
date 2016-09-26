;;; socyl.el --- Socyl, the emacs frontend for several search tools

;; Author: Nicolas Lamirault <nicolas.lamirault@gmail.com>
;; URL: https://github.com/nlamirault/socyl
;; Version: 0.1.0
;; Keywords: ripgrep sift ack pt ag grep search

;; Package-Requires: ((s "1.11.0") (dash "2.12.0") (pkg-info "0.5.0"))

;; Copyright (C) 2016 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

;; Provides a frontend for several search tools

;;; Installation:

;; Available as a package in melpa

;; (add-to-list 'package-archives
;;              '("melpa" . "https://stable.melpa.org/packages/") t)
;;
;; M-x package-install socyl

;;; Usage:


;;; Code:


(require 'socyl-version)
(require 'socyl-custom)
(require 'socyl-backend)
(require 'socyl-mode)
(require 'socyl-sift)
(require 'socyl-pt)
(require 'socyl-ag)



(provide 'socyl)
;;; socyl.el ends here
