;;; socyl-custom.el --- Socyl customization

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


;; Faces
;; --------------------------


(defgroup socyl nil
  "Socyl utility"
  :group 'tools
  :group 'matching
  :link '(url-link :tag "Socyl" "https://github.com/nlamirault/socyl")
  :link '(emacs-commentary-link :tag "Commentary" "socyl"))

(defcustom socyl-highlight-search t
  "Non-nil means we highlight the current search term in results."
  :type 'boolean
  :group 'socyl)

(defface socyl-hit-face '((t :inherit compilation-info))
  "Face name to use for matches."
  :group 'socyl)


(defface socyl-match-face '((t :inherit match))
  "Face name to use for matches."
  :group 'socyl)



(provide 'socyl-custom)
;;; socyl-custom.el ends here
