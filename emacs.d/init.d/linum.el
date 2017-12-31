
(req-package linum
  :require (hl-line)
  :config (progn
            (defface linum-highlight-face
              '((t (:inherit default :foreground "black"
                             :background "gray")))
              "Face for highlighting current line"
              :group 'linum)

            ;; set custom faces
            (custom-set-faces
             '(linum ((t (:inherit default :background "#1d1f21" :foreground "#969896"))))
             '(linum-highlight-face ((t (:inherit default :background "#282a2e" :foreground "#969896")))))

            (global-linum-mode 1)

            ;; auto scale width based on total lines
            (unless window-system
              (add-hook 'linum-before-numbering-hook
                        (lambda ()
                          (setq-local linum-format-fmt
                                      (let ((w (length (number-to-string
                                                        (count-lines (point-min) (point-max))))))
                                        (concat "%" (number-to-string w) "d"))))))

            ;; store current line
            (defvar linum-current-line 0)

            ;; define a custom face if we are on the highlighted line
            (defun linum-format-face (line)
              (if (eq line linum-current-line)
                  'linum-highlight-face
                'linum))

            ;;actually format the line number
            (defun linum-format-func (line)
              (concat
               (propertize (format linum-format-fmt line) 'face (linum-format-face line))
               (propertize "  " 'face (linum-format-face line))))

            ;; hook set our line number formatter
            (unless window-system
              (setq linum-format 'linum-format-func))

            ;; when line number changes, update the current line
            (defadvice linum-update (around linum-update)
              (let ((linum-current-line (line-number-at-pos)))
                ad-do-it))

            ;;;;;;;;;;;
            ;; Disabling linenumbers per major mode
            (setq linum-disabled-modes-list '(eshell-mode
                                              wl-summary-mode
                                              compilation-mode
                                              ;;org-mode
                                              ;;text-mode
                                              dired-mode
                                              doc-view-mode
                                              image-mode
                                              paradox-menu-mode)
                  linum-disable-starred-buffers 'f
                  linum-delay t)

            (defun linum-on ()
              "* When linum is running globally, disable line number in modes defined in `linum-disabled-modes-list'. Changed by linum-off. Also turns off numbering in starred modes like *scratch*"
              (unless (or (minibufferp)
                          (member major-mode linum-disabled-modes-list)
                          (and (not  linum-disable-starred-buffers) (string-match (rx-to-string `(: bos ,"*") t) (buffer-name)))
                          (> (buffer-size) 3000000)) ;; disable linum on buffer greater than 3MB, otherwise it's unbearably slow
                (linum-mode 1)))

            (ad-activate 'linum-update)))

(provide 'init-linum)
