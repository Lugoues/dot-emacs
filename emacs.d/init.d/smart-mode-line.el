
(req-package smart-mode-line
  :require (dash rich-minority )
  :config (progn (setq display-time-24hr-format t
                       display-time-default-load-average nil
                       sml/battery-format " %p%%  "
                       sml/shorten-modes nil
                       sml/shorten-directory t
                       sml/apply-theme 'dark
                       sml/use-projectile-p 'before-prefixes
                       sml/mode-width 'right)

                 (display-battery-mode 1)
                 (display-time-mode 1)

                 (sml/setup)

                 ;;reset projectile otherwise sml integration doesn't work
                 (projectile-mode 0)
                 (projectile-mode 1)
                 (add-to-list 'sml/replacer-regexp-list '("^~/\\.emacs\\.d/" ":emacs.d:") t)
                 (add-to-list 'sml/replacer-regexp-list '("^/sudo:.*:" ":su:") t)
                 (add-to-list 'sml/replacer-regexp-list '("^~/Documents/" ":doc:") t)
                 (add-to-list 'sml/replacer-regexp-list '("^~/Dropbox/" ":db:") t)
                 (add-to-list 'sml/replacer-regexp-list '("^~/dev/" ":dev:") t)))

(provide 'init-smart-mode-line)
