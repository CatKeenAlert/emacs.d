
;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

(let ((minver "23.3"))
  (when (version<= emacs-version "23.1")
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Temporarily reduce garbage collection during startup
;;----------------------------------------------------------------------------
(defconst sanityinc/initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold sanityinc/initial-gc-cons-threshold)))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-compat)
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-preload-local.el"
;;----------------------------------------------------------------------------
(require 'init-preload-local nil t)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

(require-package 'wgrep)
(require-package 'project-local-variables)
(require-package 'diminish)
(require-package 'scratch)
(require-package 'mwe-log-commands)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;;;;; set w3m for webbrowse  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
(require 'w3m-load)  
;;(require 'mime-w3m)  
(require 'w3m)  
(autoload 'w3m "w3m" "interface for w3m on emacs" t)  
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)  
;;(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)  

(require 'w3m-search)
(setq w3m-search-default-engine "php.net")
(add-to-list 'w3m-search-engine-alist
                     '("php.net" "http://php.net/zh/search.php?show=quickref&pattern=%s"))
 ;; Make the previous search engine the default for the next
 ;;     ;; search.
 (defadvice w3m-search (after change-default activate)
                  (let ((engine (nth 1 minibuffer-history)))
                        (when (assoc engine w3m-search-engine-alist)
                              (setq w3m-search-default-engine engine))))

  
  ;settings  
  (setq w3m-use-cookies t)  
  (setq w3m-home-page "http://php.net/")  
    
    ;; 默认显示图片  
    (setq w3m-default-display-inline-image t)   
    (setq w3m-default-toggle-inline-images t)  
      
      (setq w3m-use-form t)  
      (setq w3m-tab-width 8)  
      (setq w3m-use-cookies t)       ;;使用cookies  
      (setq w3m-use-toolbar t)  
      (setq w3m-use-mule-ucs t)  
      ;(setq w3m-fill-column 120)  
      (setq browse-url-browser-function 'w3m-browse-url)  
      (setq w3m-view-this-url-new-session-in-background t)  
        
        ;; 使用w3m作为默认浏览器  
        (setq browse-url-browser-function 'w3m-browse-url)                  
        (setq w3m-view-this-url-new-session-in-background t)  
          
          ;;显示图标                                                        
          (setq w3m-show-graphic-icons-in-header-line t)                    
          (setq w3m-show-graphic-icons-in-mode-line t)   
          (defun remove-w3m-output-garbages ()                              
          ;"去掉w3m输出的垃圾."                                              
          (interactive)                                                     
          (let ((buffer-read-only))                                         
          (setf (point) (point-min))                                        
          (while (re-search-forward "[\200-\240]" nil t)                    
          (replace-match " "))                                              
          (set-buffer-multibyte t))                                         
          (set-buffer-modified-p nil))  
           
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;;;;; lines above is I add in,  set w3m as webbrowse,  the php.net Chinese search engine is default search engine.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

(require 'init-frame-hooks)
(require 'init-xterm)
(require 'init-themes)
(require 'init-osx-keys)
(require 'init-gui-frames)
(require 'init-dired)
(require 'init-isearch)
(require 'init-grep)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flycheck)

(require 'init-recentf)
(require 'init-ido)
(require 'init-hippie-expand)
(require 'init-company)
(require 'init-windows)
(require 'init-sessions)
(require 'init-fonts)
(require 'init-mmm)

(require 'init-editing-utils)
(require 'init-whitespace)
(require 'init-fci)

(require 'init-vc)
(require 'init-darcs)
(require 'init-git)
(require 'init-github)

(require 'init-projectile)

(require 'init-compile)
(require 'init-crontab)
(require 'init-textile)
(require 'init-markdown)
(require 'init-csv)
(require 'init-erlang)
(require 'init-javascript)
(require 'init-php)
(require 'init-org)
(require 'init-nxml)
(require 'init-html)
(require 'init-css)
(require 'init-haml)
(require 'init-python-mode)
(unless (version<= emacs-version "24.3")
  (require 'init-haskell))
(require 'init-elm)
(require 'init-ruby-mode)
(require 'init-rails)
(require 'init-sql)

(require 'init-paredit)
(require 'init-lisp)
(require 'init-slime)
(unless (version<= emacs-version "24.2")
  (require 'init-clojure)
  (require 'init-clojure-cider))
(require 'init-common-lisp)

(when *spell-check-support-enabled*
  (require 'init-spelling))

(require 'init-misc)

(require 'init-dash)
(require 'init-ledger)
;; Extra packages which don't require any configuration

(require-package 'gnuplot)
(require-package 'lua-mode)
(require-package 'htmlize)
(require-package 'dsvn)
(when *is-a-mac*
  (require-package 'osx-location))
(require-package 'regex-tool)

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(when (file-exists-p custom-file)
  (load custom-file))


;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------------------
(when (file-exists-p (expand-file-name "init-local.el" user-emacs-directory))
  (error "Please move init-local.el to ~/.emacs.d/lisp"))
(require 'init-local nil t)


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)

(add-hook 'after-init-hook
          (lambda ()
            (message "init completed in %.2fms"
                     (sanityinc/time-subtract-millis after-init-time before-init-time))))


(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:


;;neotree: This extension try to simulat nerdtree(vim directory tree extension).
;;(add-to-list 'load-path "/some/path/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)



;;(add-to-list 'load-path "~/.emacs.d/lisp/")
;;(add-to-list 'load-path "~/.emacs.d/lisp/geben")
(require 'geben)
(require 'dbgp)


;; use apsell as ispell backend  
(setq-default ispell-program-name "aspell")  
;; ;; use American English as ispell default dictionary  
(ispell-change-dictionary "american" t) 

;;(setq html-mode-hook '(lambda()  
;;                        (flyspell-mode t) 
;;                        ))
;;(setq php-mode-hook '(lambda()  
;;                        (flyspell-mode t) 
;;                        ))
;;(setq js-mode-hook '(lambda()  
;;                        (flyspell-mode t) 
;;                        ))
;;(setq js2-mode-hook '(lambda()  
;;                        (flyspell-mode t) 
;;                        ))

(require 'chm-view)
;;set default chm view delay time to a bigger number, waiting for rchmage load chm file over. if load completely, also get the error: “Cannot retrieve URL: http://localhost:531560 (exit status: 0)”, refresh again, it will works well.
(setq-default chm-view-delay  59)  


;;auto use evil
(require 'evil) 
(evil-mode 1) 
