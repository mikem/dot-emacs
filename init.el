;; See http://clojure-doc.org/articles/tutorials/emacs.html

;; fix the PATH variable
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      clojure-mode
                      clojure-test-mode
                      nrepl
                      workgroups
                      win-switch
                      simpleclip))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; See http://stackoverflow.com/a/2079146/2576
(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
    (load-file (expand-file-name file user-init-dir)))

(load-user-file "org.el")

(require 'workgroups)

(require 'win-switch)
;; (win-switch-setup-keys-ijkl "\C-xo")
(global-unset-key "\C-xo")
(global-set-key "\C-xo" 'win-switch-dispatch)
