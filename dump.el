;;-*- lexical-binding: t -*-
(add-to-list 'load-path
             (expand-file-name "site-lisp"
                               user-emacs-directory))
(require 'luna-f)
(require 'lunary)
(require 'cowboy)

(setq package-user-dir (expand-file-name "package" user-emacs-directory))
(package-initialize)
(cowboy-add-load-path)
(setq luna-dumped-load-path load-path
      luna-dumped t)
(dolist (package '(use-package company ivy counsel org helpful
                   general helpful use-package general which-key
                   recentf-ext swiper ivy-prescient find-char
                   aggressive-indent windman doom-themes winner
                   elec-pair doom-one-light-theme undo-tree
                   doom-cyberpunk-theme rainbow-delimiters
                   highlight-parentheses hl-todo buffer-move
                   savehist eyebrowse minions ws-butler
                   expand-region isolate outshine flyspell ;; magit
                   eglot minibuf-eldef form-feed all-the-icons
                   sly-el-indent))
  (require package))
(load-theme 'doom-one-light t t)
(load-theme 'doom-cyberpunk t t)

(dump-emacs-portable luna-dump-file)
