
;; define variables
(defvar emacs-dir (file-name-directory load-file-name))
(defvar el-get-dir (expand-file-name "el-get/" emacs-dir))
(defvar recipes-dir (expand-file-name "recipes/" emacs-dir))
(defvar patches-dir (expand-file-name "patches/" emacs-dir))
;(defvar config-dir (expand-file-name "config/" emacs-dir))
(defvar config-dir (expand-file-name "init.d/" emacs-dir))

;; Setup package sources
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;;(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/"))
;;(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("sunrise" . "http://joseito.republika.pl/sunrise-commander/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; we need to install the stable version of cider
(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(flycheck-cider . "melpa-stable") t)

(eval-when-compile (package-initialize))

(defun require-package (package)
  "refresh package archives, check package presence and install if it's not installed"
  (if (null (require package nil t))
      (progn (let* ((ARCHIVES (if (null package-archive-contents)
          (progn (package-refresh-contents)
           package-archive-contents)
        package-archive-contents))
        (AVAIL (assoc package ARCHIVES)))
         (if AVAIL
       (package-install package)))
       (require package))))

;; Set peristence location
(setq emacs-persistence-directory  (concat user-emacs-directory "persistence"))
(unless (file-exists-p emacs-persistence-directory)
  (make-directory emacs-persistence-directory t))

;; setup backup directory and life time
(setq backup-directory-alist `((".*" . ,emacs-persistence-directory))
      auto-save-file-name-transforms `((".*" ,emacs-persistence-directory))
      make-backup-files t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t
      auto-save-default t
      auto-save-timeout 20
      auto-save-interval 200)

;; we don't want to lock files
(setq create-lockfiles nil)

;;   Install req-package
(require-package 'req-package)

;;(req-package-force el-get
;;  :init (progn (add-to-list 'el-get-recipe-path (expand-file-name "recipes/" emacs-dir))
;;               (add-to-list 'el-get-recipe-path (expand-file-name  "el-get/recipes" el-get-dir))
;;               (el-get 'sync)))

;; process inits
(req-package-force load-dir
  :init (progn (require 'load-dir)
         (load-dir-one config-dir)))

;; trigger req-package
(req-package-finish)
