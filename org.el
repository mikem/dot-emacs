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
