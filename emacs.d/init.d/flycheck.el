
(req-package flycheck
  :init
  (progn
    (setq flycheck-indication-mode 'left-fringe)
    ;; disable the annoying doc checker
    (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))
  :config
  (global-flycheck-mode 1))


(req-package flyspell
  :ensure t
  :diminish ""
  :init
  (progn
    ;; Enable spell check in program comments
    (add-hook 'prog-mode-hook 'flyspell-prog-mode)
    ;; Enable spell check in plain text / org-mode
    (add-hook 'text-mode-hook 'flyspell-mode)
    (add-hook 'org-mode-hook 'flyspell-mode)
    (setq flyspell-issue-welcome-flag nil)
    (setq flyspell-issue-message-flag nil)

    ;; ignore repeated words
    (setq flyspell-mark-duplications-flag nil)

    (setq-default ispell-program-name "/usr/bin/aspell")
    (setq-default ispell-list-command "list"))
  :config
  (custom-set-faces
   `(flyspell-incorrect ((t (:inherit nil :underline (:color "Red1" :style wave))))))
  (progn
    ;; Make spell check on right click.
    (define-key flyspell-mouse-map [down-mouse-3] 'flyspell-correct-word)
    (define-key flyspell-mouse-map [mouse-3] 'undefined)
    (define-key flyspell-mode-map (kbd "C-;") nil)))


(provide 'init-flycheck)
