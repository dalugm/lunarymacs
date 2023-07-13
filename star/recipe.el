;; -*- lexical-binding: t -*-

(setq cowboy-recipe-alist
      '((matlab . (:http "https://git.code.sf.net/p/matlab-emacs/src"))
        (breadcrumb . (:repo "joaotavora/breadcrumb"))
        (inspector . (:repo "mmontone/emacs-inspector"))
        ;; Full clones.
        (expand-region . (:repo "casouri/expand-region.el"
                                :option (:full-clone t)))
        (eldoc-box . (:repo "casouri/eldoc-box"
                            :option (:full-clone t)))
        (isolate . (:repo "casouri/isolate" :option (:full-clone t)))
        (ftable . (:repo "casouri/ftable" :option (:full-clone t)))
        (ghelp . (:repo "casouri/ghelp" :option (:full-clone t)))
        (iscroll . (:repo "casouri/iscroll" :option (:full-clone t)))
        (valign . (:repo "casouri/valign" :option (:full-clone t)))
        (zeft . (:repo "casouri/zeft" :option (:full-clone t)))
        (xeft . (:repo "casouri/xeft" :option (:full-clone t)))
        (vundo . (:repo "casouri/vundo" :option (:full-clone t)))
        (undo-hl . (:repo "casouri/undo-hl" :option (:full-clone t)))
        (stimmung-themes . (:repo "motform/stimmung-themes" :option (:full-clone t)))
        ))
