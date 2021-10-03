;;-*- lexical-binding: t -*-

;;; Init

(add-to-list 'load-path
             (expand-file-name "site-lisp"
                               user-emacs-directory))
(require 'lunary)
(require 'cowboy)
(require 'package)

;;; Custom & local

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(luna-safe-load custom-file)
(luna-local-load)

;;; Dump

(luna-if-dump
    (progn
      (setq load-path luna-dumped-load-path)
      (global-font-lock-mode)
      (transient-mark-mode)
      (add-hook 'after-init-hook
                (lambda ()
                  (save-excursion
                    (switch-to-buffer "*scratch*")
                    (goto-char (point-min))
                    (insert ";;          E M A C S\n")
                    (insert ";;\n")
                    (insert (format ";; Welcome to GNU Emacs %s.\n"
                                    emacs-version))
                    (insert (format ";; Today is %s.\n"
                                    (format-time-string "%A %Y.%-m.%-d")))
                    (insert ";;\n")
                    (lisp-interaction-mode)))))
  ;; Add load-paths and load autoload files.
  (luna-load-relative "star/recipe.el")
  (package-initialize)
  (cowboy-add-load-path))

;;; Benchmark

;; (require 'benchmark-init)
;; (add-hook 'after-init-hook 'benchmark-init/deactivate)
;; (benchmark-init/activate)

;;; Configs

;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(luna-key-def-preset :leader
  :keymaps 'override
  :prefix (if (display-graphic-p) "C-SPC" "C-@"))

(luna-key-def-preset :leader-prefix
  :prefix (if (display-graphic-p) "C-SPC" "C-@"))

(require 'no-littering)
(luna-load-relative "star/etc.el")
(luna-load-relative "star/key.el")
(luna-load-relative "star/angel.el")
(luna-load-relative "star/ui.el")
(luna-load-relative "star/mode-line.el")
(luna-load-relative "star/edit.el")
(luna-load-relative "star/checker.el")
(luna-load-relative "star/eglot.el")
(luna-load-relative "star/python.el")
(luna-load-relative "star/git.el")
(luna-load-relative "star/dir.el")
(luna-load-relative "star/org-mode.el")
(luna-load-relative "star/writing.el")
(luna-load-relative "star/tex.el")
(luna-load-relative "star/simple-mode.el")
(luna-load-relative "star/highres-icon.el")
;; (luna-load-relative "star/tool-bar.el")
(luna-load-relative "star/blog.el")
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
  (if (featurep 'light)
      (enable-theme 'light)
    (load-theme 'light)))

;;;; Font
(luna-on "Brown"
  (when (display-graphic-p)
    (luna-load-font)
    (luna-load-cjk-font))
  (luna-on "Brown" (luna-enable-apple-emoji))

  (set-face-font 'mode-line
                 (font-spec :family "SF Pro Text"
                            :size 13
                            :weight 'light))
  ;; Face defined in etc.el.
  (set-face-font 'custom-default
                 (font-spec :family "SF Pro Text" :size 13)))

;;;; Macports
(luna-on "Brown"
  (add-to-list 'load-path "/opt/local/share/emacs/site-lisp"))

;;;; Mac
(luna-on "Brown"
  (menu-bar-mode -1)
  (setq mac-option-modifier 'meta
        mac-command-modifier 'super
        mac-pass-command-to-system nil ; fix cmd h
        mac-system-move-file-to-trash-use-finder t)

  (global-set-key (kbd "s-c") #'kill-ring-save)
  (global-set-key (kbd "s-v") #'yank))

;;;; ENV
(luna-on "Brown"
  (luna-load-env)
  ;; Because Apple.
  (when (equal default-directory "/") (cd "~/")))

;;;; Smooth scrolling
(luna-on "Brown"
  (setq scroll-up-aggressively 0.01
        scroll-down-aggressively 0.01
        scroll-margin 0
        scroll-conservatively 5
        redisplay-skip-fontification-on-input t))

;;; Local init

(let ((local-init (expand-file-name
                   "local-init.el" user-emacs-directory)))
  (when (file-exists-p local-init)
    (load local-init)))

;;; Tree-sitter

(when (boundp 'tree-sitter-parser-list)
  (push "~/p/tree-sitter-expr/build-module/dist" load-path)
  (require 'tree-sitter)
  (load "~/emacs/test/src/tree-sitter-tests.el")

  (defun tree-sitter-show-buffer-tree ()
    (interactive)
    (let ((root-node (tree-sitter-parser-root-node
                      (or (car tree-sitter-parser-list)
                          (tree-sitter-create-parser (current-buffer) (tree-sitter-c))))))
      (pop-to-buffer (get-buffer-create "*tree-sitter-show-tree*"))
      (erase-buffer)
      (insert (pp-to-string (read (tree-sitter-node-string root-node)))))))

(put 'narrow-to-region 'disabled nil)

;;; Source

(luna-on "Brown"
  (setq source-directory (expand-file-name "~/emacs")))

;;; External programs

(luna-on "Brown"
  (setq xref-search-program "rg"))
