
;;General config
(setq inhibit-splash-screen t)
(recentf-mode 1)
(setq column-number-mode t)

;; (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Highlight current line
(global-hl-line-mode 1)
(setq-default indent-tabs-mode nil)
(global-prettify-symbols-mode 1)

;; Themes
(req-package color-theme-sanityinc-tomorrow
  :config (load-theme 'sanityinc-tomorrow-night t))

(req-package delight)

(req-package rainbow-mode
  :delight
  :config (rainbow-mode 1))

(req-package rainbow-delimiters
  :config (progn (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)))

(req-package aggressive-indent
  :config (global-aggressive-indent-mode 1))

(req-package which-key
  :delight
  :init
  (which-key-mode)
  :config
  (which-key-setup-side-window-bottom)
  (setq which-key-idle-delay 0.05))

;; Add parts of each file's directory to the buffer name if not unique
(req-package uniquify
  :config
  (setq uniquify-buffer-name-style 'forward))

(provide 'init-look-and-feel)
