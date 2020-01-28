;;-*- lexical-binding: t -*-

;; (require 'profiler)
;; (profiler-start 'cpu)

(when (eq window-system 'mac)
  ;; have to enable menu bar on mac port
  ;; otherwise emacs lost focus
  (menu-bar-mode))

;;; Package

(add-to-list 'load-path
             (expand-file-name "site-lisp"
                               user-emacs-directory))
(require 'luna-f)
(require 'lunary)
(require 'cowboy)
(require 'package)

(luna-if-dump
    (progn
      (setq load-path luna-dumped-load-path)
      (global-font-lock-mode)
      (transient-mark-mode)
      (add-hook 'after-init-hook
                (lambda ()
                  (save-excursion
                    (switch-to-buffer "*scratch*")
                    (lisp-interaction-mode)))))
  (setq package-user-dir (expand-file-name "package" user-emacs-directory))
  ;; add load-path’s and load autoload files
  (package-initialize)
  (cowboy-add-load-path))

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq luna-company-manual nil)
(add-to-list 'luna-package-list 'use-package)

(luna-message-error (require 'use-package))
(setq use-package-hook-name-suffix "")
;; core must load first because other configs depends on them
(luna-load-relative "star/builtin-config.el")
(luna-load-relative "star/key.el")
(luna-load-relative "star/recipe.el")
(luna-load-relative "star/angel.el")
(luna-load-relative "star/ui.el")
(luna-load-relative "star/mode-line.el")
(luna-load-relative "star/edit.el")
(luna-load-relative "star/homepage.el")
;; (luna-load-relative "star/helm.el")
(luna-load-relative "star/ivy.el")
(luna-load-relative "star/checker.el")
(luna-load-relative "star/company.el")
(luna-load-relative "star/eglot.el")
(luna-load-relative "star/python.el")
(luna-load-relative "star/elisp.el")
(luna-load-relative "star/git.el")
(luna-load-relative "star/dir.el")
(luna-load-relative "star/org.el")
(luna-load-relative "star/tex.el")
;; (luna-load-relative "star/term.el")
;; (luna-load-relative "star/shell.el")
(luna-load-relative "star/simple-mode.el")
(require 'utility)

;;; Customize

;;;; Custom
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(luna-load-or-create custom-file)
(add-hook 'kill-emacs-hook #'customize-save-customized)

;;;; Misc
(setq-default luna-format-on-save t)
(setq-default bidi-display-reordering nil) ;; faster long line
(setq scroll-margin 4)
(setq ispell-program-name "aspell")
(setq user-mail-address "casouri@gmail.com"
      send-mail-function #'sendmail-send-it
      message-send-mail-function #'message-send-mail-with-sendmail)
(setq split-height-threshold nil ; Popup window to right
      split-width-threshold 80)

;;;; theme
(when window-system
  (luna-load-theme))

;;;; Font
(when window-system
  (luna-load-font)
  (luna-load-cjk-font))
(setq luna-cjk-font-scale 1.1)
(luna-enable-apple-emoji)

;; WenYue GuDianMingChaoTi (Non-Commercial Use) W5
;; WenYue XHGuYaSong (Non-Commercial Use)
;; WenyueType GutiFangsong (Non-Commercial Use)
;; SiaoyiWangMingBold
;; FZQingKeBenYueSongS-R-GB
;; FZSongKeBenXiuKaiS-R-GB

;;;; nyan
;; (nyan-lite-mode)
;; (setq nyan-wavy-trail t)
;; enabling this makes highlight on buttons blink
;; (nyan-start-animation)

;;;; server
;; checking whether server started can be slow
;; see emacs-horror
(unless luna-in-esup
  (run-with-idle-timer
   3 nil
   (lambda () (ignore-errors (server-start)))))

;;;; Mac port
(setq mac-option-modifier 'meta
      mac-command-modifier 'super
      mac-pass-command-to-system nil ; fix cmd h
      mac-system-move-file-to-trash-use-finder t)

(global-set-key (kbd "s-c") #'kill-ring-save)
(global-set-key (kbd "s-v") #'yank)

;;;; notmuch
;; (add-to-list 'load-path "/opt/local/share/emacs/site-lisp/notmuch")
;; (setq notmuch-init-file (luna-f-join user-emacs-directory "star/notmuch-config.el"))
;; (setq message-auto-save-directory "~/mail/draft")
;; (setq message-kill-buffer-on-exit t)
;; (setq notmuch-search-oldest-first nil)
;; (require 'notmuch)

;;;; ENV
(luna-load-env)

;;;; ghelp

(add-to-list 'load-path "~/p/ghelp")
(require 'ghelp)
(ghelp-global-minor-mode)

;;;; trivial-copy
(luna-when-mac
 (add-to-list 'load-path "~/p/trivial-copy")
 (require 'trivial-copy))

;;;; notdeft
(add-to-list 'load-path "~/attic/notdeft")

;; (profiler-report)

(when luna-in-esup
  (remove-hook 'kill-emacs-hook #'customize-save-customized))

;;;; Local unsynced customization

(luna-load-or-create "local-config.el")
