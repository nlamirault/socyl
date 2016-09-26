;;; socyl-mode.el --- Socyl search mode

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

;;; Code:


(require 'compile)
(require 'grep)
;; (require 'thingatpt)


(require 'socyl-custom)


(defvar socyl--search-finished-hook nil
  "Hook run when sift completes a search in a buffer.")

(defun socyl--run-finished-hook (buffer how-finished)
  "Run the hook to signal that the search has completed."
  (with-current-buffer buffer
    (run-hooks 'socyl--search-finished-hook)))

(defvar socyl-search-mode-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map compilation-minor-mode-map)
    (define-key map "p" 'compilation-previous-error)
    (define-key map "n" 'compilation-next-error)
    (define-key map "{" 'compilation-previous-file)
    (define-key map "}" 'compilation-next-file)
    (define-key map "k" '(lambda ()
                           (interactive)
                           (let ((kill-buffer-query-functions))
                             (kill-buffer))))
    map)
  "Keymap for socyl-search buffers.
`compilation-minor-mode-map' is a cdr of this.")



;; Taken from grep-filter, just changed the color regex.
(defun socyl--filter ()
  "Handle match highlighting escape sequences inserted by the backend process.
This function is called from `compilation-filter-hook'."
  (when socyl-highlight-search
    (save-excursion
      (forward-line 0)
      (let ((end (point)) beg)
        (goto-char compilation-filter-start)
        (forward-line 0)
        (setq beg (point))
        ;; Only operate on whole lines so we don't get caught with part of an
        ;; escape sequence in one chunk and the rest in another.
        (when (< (point) end)
          (setq end (copy-marker end))
          ;; Highlight matches and delete marking sequences.
          (while (re-search-forward "\033\\[30;43m\\(.*?\\)\033\\[[0-9]*m" end 1)
            (replace-match (propertize (match-string 1)
                                       'face nil 'font-lock-face 'sift-match-face)
                           t t))
          ;; Delete all remaining escape sequences
          (goto-char beg)
          (while (re-search-forward "\033\\[[0-9;]*[mK]" end 1)
            (replace-match "" t t)))))))


(define-compilation-mode socyl-search-mode "Socyl"
  "Socyl backend searcher results compilation mode"
  (set (make-local-variable 'truncate-lines) t)
  (set (make-local-variable 'compilation-disable-input) t)
  (set (make-local-variable 'tool-bar-map) grep-mode-tool-bar-map)
  (let ((symbol 'compilation-socyl)
        (pattern '("^\\([^:\n]+?\\):\\([0-9]+\\):[^0-9]" 1 2)))
    (set (make-local-variable 'compilation-error-regexp-alist) (list symbol))
    (set (make-local-variable 'compilation-error-regexp-alist-alist) (list (cons symbol pattern))))
  (set (make-local-variable 'compilation-error-face) 'socyl-hit-face)
  (add-hook 'compilation-filter-hook 'socyl--filter nil t))



(provide 'socyl-mode)
;;; socyl-mode.el ends here
