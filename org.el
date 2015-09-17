;; Set to the location of your Org files on your local system
(setq org-directory "~/org")

;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/flagged.org")

;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

;; Enable encryption
(setq org-mobile-use-encryption t)

;; Set a password
(setq org-mobile-encryption-password
      (with-temp-buffer
        (insert-file-contents-literally "~/.emacs.d/org-mobile-encryption-password.txt")
        (car (split-string (buffer-string) "\n" t))))

;; Set files to sync
(setq org-mobile-files '((org-agenda-files) "~/org"))
(setq org-mobile-files-exclude-regexp "flagged.org\\|done.org\\|no-sync")

;; More options
(setq org-todo-keywords '((sequence "TODO" "DOING" "|" "DONE")))

;; Load stuff after initialization
(eval-after-load "org"
  '(require 'ox-md nil t))

;; Markdown-style link IDs
;; see:
;; http://emacs.stackexchange.com/questions/594/how-to-implement-markdown-style-link-ids-in-org-mode
(require 'org)
(org-add-link-type "lid" 'endless/open-id-link 'endless/export-id-link)

(defun endless/open-id-link (path)
  "Follow an ID link to PATH."
  (browse-url (endless/find-id-link path)))

(defun endless/export-id-link (path desc format)
  "Create the export version of an ID link specified by PATH and DESC.
FORMATs understood are 'latex and 'html."
  (setq path (endless/find-id-link path))
  (cond
   ((eq format 'html) (format "<a href=\"%s\">%s</a>" path desc))
   ((eq format 'latex) (format "\\href{%s}{%s}" path desc))
      (t desc)))

(defun endless/find-id-link (id &optional noerror)
  "Find \"#+LINK-ID: ID\" in current buffer and return the link.
Unless NOERROR is non-nil, throw an error if link not found."
  (save-excursion
    (goto-char (point-min))
    (let ((case-fold-search t))
      (when (search-forward-regexp
             (format "^#\\+LINK-ID: \\b%s\\b +\\(.*\\) *$" id)
             nil noerror)
                (match-string-no-properties 1)))))
