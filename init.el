;;-*- lexical-binding: t -*-

;;; Init

(push (expand-file-name "site-lisp" user-emacs-directory) load-path)
(require 'lunary)
(require 'cowboy)
(require 'package)

;;; Custom file

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(luna-safe-load custom-file)

;;; Dump

(luna-if-dump
    (progn
      (setq load-path luna-dumped-load-path)
      (global-font-lock-mode)
      (transient-mark-mode))
  ;; Add load-paths and load autoload files.
  (luna-load-relative "star/recipe.el")
  (package-initialize)
  (cowboy-add-load-path))

;;; Benchmark

;; (require 'benchmark-init)
;; (add-hook 'after-init-hook 'benchmark-init/deactivate)
;; (benchmark-init/activate)

;;; Configs

(luna-key-def-preset :leader
  :keymaps 'override
  :prefix (if (display-graphic-p) "C-SPC" "C-@"))

(luna-key-def-preset :leader-prefix
  :prefix (if (display-graphic-p) "C-SPC" "C-@"))

(luna-load-relative "star/etc.el")
(luna-load-relative "star/key.el")
(luna-load-relative "star/angel.el")
(luna-load-relative "star/ui.el")
(luna-load-relative "star/mode-line.el")
(luna-load-relative "star/edit.el")
(luna-load-relative "star/completion.el")
(luna-load-relative "star/checker.el")
(luna-load-relative "star/python.el")
(luna-load-relative "star/git.el")
(luna-load-relative "star/dir.el")
(luna-load-relative "star/org-mode.el")
(luna-load-relative "star/writing.el")
(luna-load-relative "star/tex.el")
(luna-load-relative "star/simple-mode.el")
(luna-load-relative "star/blog.el")
(luna-load-relative "star/app.el")
(require 'utility)

;;; Server
(run-with-idle-timer
 3 nil (lambda ()
         (require 'server)
         (unless (server-running-p)
           (server-start t t))))

;;; Customize

;;;; Theme
(when (window-system)
  (luna-load-theme 'pale))

(luna-on "Brown"
;;;; Font
  (when (display-graphic-p)

	(luna-enable-apple-emoji)
    (luna-load-font 'default "IBM Plex Mono" 13 :weight 'medium)
    (luna-load-font 'fixed-pitch "IBM Plex Mono" 13 :weight 'medium)
    (luna-load-font 'variable-pitch "SF Pro Text" 16)
    (luna-load-font 'mode-line "SF Pro Text" 13 :weight 'light)
    (advice-add #'load-theme
                :after (lambda (&rest _)
                         (luna-load-font
                          'mode-line
                          "SF Pro Text" 13 :weight 'light))))
;;;; Frame
  (when (display-graphic-p)
    (set-frame-width (selected-frame) 150)
    (set-frame-height (selected-frame) 44)
    (set-frame-position nil 30 50))
;;;; Keys
  (setq mac-option-modifier 'meta
        mac-command-modifier 'super
        mac-pass-command-to-system nil ; fix cmd h
        mac-system-move-file-to-trash-use-finder t)
  (global-set-key (kbd "s-c") #'kill-ring-save)
  (global-set-key (kbd "s-v") #'yank)
;;;; Environment
  (if luna-dumped
      (dolist (var luna-env-vars)
        (exec-path-from-shell-setenv (car var) (cdr var)))
    (exec-path-from-shell-initialize))
  (add-to-list 'load-path "/opt/local/share/emacs/site-lisp")
  (setq source-directory (expand-file-name "~/emacs"))
  (setq xref-search-program 'ripgrep)
;;;; Scrolling
  (setq scroll-up-aggressively 0.01
        scroll-down-aggressively 0.01
        redisplay-skip-fontification-on-input t)
  (setq mouse-wheel-flip-direction t))

;;; Local init

(let ((local-init (expand-file-name
                   "local-init.el" user-emacs-directory)))
  (when (file-exists-p local-init)
    (luna-safe-load local-init)))
