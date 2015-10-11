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
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(defvar my-packages '(;; emacs
                      starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      workgroups
                      win-switch
                      simpleclip
                      magit
                      ;; clojure
                      clojure-mode
                      clojure-test-mode
                      nrepl
                      ;; scala
                      scala-mode2
                      sbt-mode
                      ensime
                      ;; web
                      web-mode
                      scss-mode))

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

;; general
(add-hook 'local-write-file-hooks
          (lambda ()
            (delete-trailing-whitespace)
                           nil))

(global-set-key "\C-c\C-c" 'comment-region)

(require 'workgroups)

(require 'win-switch)
;; (win-switch-setup-keys-ijkl "\C-xo")
(global-unset-key "\C-xo")
(global-set-key "\C-xo" 'win-switch-dispatch)

;; Scala
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; Web
(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-code-indent-offset 2)))

(add-hook 'scss-mode-hook
          (lambda ()
            (setq css-indent-offset 2)))

(add-to-list 'auto-mode-alist '("\\.scala.html'" . web-mode))
(setq web-mode-engines-alis
      '(("razor" . "\\.scala.html\\'")))
