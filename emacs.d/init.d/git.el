
(req-package git-timemachine)

(req-package git-gutter
  :require (linum)
  :delight
  :config (progn
            (git-gutter:linum-setup)

            (setq git-gutter:update-interval 2
                  git-gutter:widow-width 2
                  git-gutter:lighter " GG"
                  ;;git-gutter:disabled-modes (asm-mode image-mode)
                  git-gutter:modified-sign "▪︎"
                  git-gutter:added-sign "+"
                  git-gutter:deleted-sign "⬍"
                  git-gutter:unchanged-sign nil)

            (set-face-foreground 'git-gutter:modified "#967EFB")
            (set-face-foreground 'git-gutter:added "#A6E22E")
            (set-face-foreground 'git-gutter:deleted "#F92672")

            (add-to-list 'git-gutter:update-hooks 'focus-in-hook)
            (add-to-list 'git-gutter:update-hooks 'after-change-major-mode-hook)

            ;; Key bindings
            (global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
            (global-set-key (kbd "C-x n") 'git-gutter:next-hunk)
            (global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)
            (global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)
            (global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

            (global-git-gutter-mode +1)
            ))

(req-package magit
  :require (git-gutter)
  :config
  (defhydra hydra-git
    "
^NAV^               ^HUNK^            ^FILES^        ^ACTIONS^
  _n_: next hunk    _s_tage hunk      _S_tage        _c_ommit
  _p_: prev hunk    _r_evert hunk     _R_evert       _b_lame
_C-P_: first hunk   _P_opup hunk      _d_iff         _C_heckout
_C-N_: last hunk    _R_evision start  _t_imemachine
"
    ("n" git-gutter:next-hunk)
    ("p" git-gutter:previous-hunk)
    ("C-P" (progn (goto-char (point-min)) (git-gutter:next-hunk 1)))
    ("C-N" (progn (goto-char (point-min)) (git-gutter:previous-hunk 1)))
    ("s" git-gutter:stage-hunk)
    ("r" git-gutter:revert-hunk)
    ("P" git-gutter:popup-hunk)
    ("R" git-gutter:set-start-revision)
    ("S" magit-stage-file)
    ("R" magit-revert)
    ("d" magit-diff-unstaged :color blue)
    ("t" git-timemachine :color blue)
    ("c" magit-commit :color blue)
    ("b" magit-blame)
    ("C" magit-checkout)
    ("v" magit-status "status" :color blue)
    ("q" nil "quit" :color blue)
    ("Q" (progn
           (git-gutter-mode -1)
           ;; git-gutter-fringe doesn't seem to
           ;; clear the markup right away
           (sit-for 0.1)
           (git-gutter:clear))
     "quit git-gutter"
     :color blue))
  )

(provide 'init-git)