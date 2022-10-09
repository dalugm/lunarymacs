;; -*- lexical-binding: t -*-

(luna-key-def
 :leader
 "g"  '("git")
 "gs" #'magit-status
 "gf" '("file")
 "gfc" #'magit-file-checkout
 "gfl" #'magit-log-buffer-file
 :---
 :keymaps 'magit-mode-map
 "<tab>" #'magit-section-toggle)

(load-package magit
  :commands magit-status
  :config
  ;; Speed up magit in large repos.
  (setq magit-refresh-status-buffer nil
        ;; Show refined diff.
        magit-diff-refine-hunk t)

  ;; Disable electric-quote-mode in commit message buffer.
  (add-hook 'text-mode-hook
            (lambda ()
              (when (equal (buffer-name) "COMMIT_EDITMSG")
                (electric-quote-local-mode -1))))

  ;; Patch
  (defun magit-patch-apply-buffer (buffer &rest args)
    "Apply the patch buffer BUFFER."
    (interactive
     (list (read-buffer "Apply patch in buffer: " nil t)
           (transient-args 'magit-patch-apply)))
    (with-temp-buffer
      (insert-buffer-substring-no-properties buffer)
      (magit-run-git-with-input "apply" args "-")
      (magit-refresh)))
  (require 'magit-patch)
  (transient-append-suffix 'magit-patch-apply "a"
    '("b" "Apply patch in buffer" magit-patch-apply-buffer)))

(load-package magit-patch-changelog
  :after magit)

(load-package magit-todos
  :autoload-hook (magit-mode . magit-todos-mode))

(load-package git-link
  :commands
  git-link
  git-link-commit
  git-link-homepage
  github-link
  github-link-commit
  github-link-homepage
  :init
  (defalias 'github-link 'git-link)
  (defalias 'github-link-commit 'git-link-commit)
  (defalias 'github-link-homepage 'git-link-hoempage))
