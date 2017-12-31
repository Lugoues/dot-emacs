
(req-package helm
  :require (helm-projectile helm-ag)
  :config (progn (helm-mode 1)
                 (helm-projectile-on)
                 (helm-autoresize-mode t)

                 (setq helm-adaptive-history-file "~/.emacs.d/data/helm-history"
                       helm-yank-symbol-first t
                       helm-move-to-line-cycle-in-source t
                       helm-buffers-fuzzy-matching t
                       helm-M-x-fuzzy-match t
                       helm-recentf-fuzzy-match t)

                 (custom-set-variables
                  '(helm-ag-base-command "rg --no-heading"))
                 
                 (global-set-key (kbd "C-x C-m") 'helm-M-x)
                 (global-set-key (kbd "M-y") 'helm-show-kill-ring)
                 (global-set-key (kbd "C-x b") 'helm-mini)
                 (global-set-key (kbd "C-x C-f") 'helm-find-files)
                 (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
                 (global-set-key (kbd "C-c h o") 'helm-occur)
                 (global-set-key (kbd "C-c h") 'helm-command-prefix)))

(provide 'init-helm)
