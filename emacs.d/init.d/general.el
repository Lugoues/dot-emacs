(require 'req-package)

(req-package general
  :config
  (general-define-key
   :prefix "C-c"
   "s" 'hydra-sp/body
   "a" '(:ignore t :which-key "Applications")
   "ag" 'hydra-git/body
   "aj" '(:ignore t :which-key "Journal")
   "ajj" 'org-journal-new-entry
   "ajv" 'view-journal
   "ajs" 'org-journal-search
   "ajS" 'search-all-journals
   "ap" '(hydra-projectile/body :which-key "Projectile")
   "p" '(:keymap projectile-command-map :package projectile :which-key "Projectile")))

(provide 'init-general)
