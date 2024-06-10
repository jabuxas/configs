(setq default-frame-alist '((font . "CartographCF Nerd Font DemiBold 16") (foreground-color . "#FFF")))
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-message t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(setq-default
 ;; Don't use the compiled code if its the older package.
 load-prefer-newer t

 ;; Do not put 'customize' config in init.el; give it another file.
 custom-file "~/.emacs.d/custom-file.el"

 fill-column 80

 ;; Use your name in the frame title. :)
 frame-title-format (format "%s's Emacs" (capitalize user-login-name))

 ;; Do not create lockfiles.
 create-lockfiles nil

 ;; Don't use hard tabs
 indent-tabs-mode nil

 ;; Emacs can automatically create backup files. This tells Emacs to put all backups in         aaaaaaaaaa
 ;; ~/.emacs.d/backups. More info:
 ;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Backup-Files.html
 backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))

 ;; Do not autosave.
 auto-save-default nil


 ;; Allow commands to be run on minibuffers.
 enable-recursive-minibuffers t)

;; Change all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; Delete whitespace just when a file is saved.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Enable narrowing commands.
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

;; Automatically update buffers if file content on the disk has changed.
(global-auto-revert-mode t)

;; Disable Line Wrapping
(toggle-truncate-lines)

(setq-default
 ;; Makes killing/yanking interact with the clipboard.
 x-select-enable-clipboard t

 ;; To understand why this is done, read `X11 Copy & Paste to/from Emacs' section here:
 ;; https://www.emacswiki.org/emacs/CopyAndPaste.
 x-select-enable-primary t

 ;; Save clipboard strings into kill ring before replacing them. When
 ;; one selects something in another program to paste it into Emacs, but
 ;; kills something in Emacs before actually pasting it, this selection
 ;; is gone unless this variable is non-nil.
 save-interprogram-paste-before-kill t

 ;; Shows all options when running apropos. For more info,
 ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Apropos.html.
 apropos-do-all t

 ;; Mouse yank commands yank at point instead of at click.
 mouse-yank-at-point t)


(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil)))

(use-package org
  :ensure t)

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/org-roam")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-id-get-create)
         ("C-c n n" . org-roam-alias-add)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config
  (org-roam-setup))

(use-package org-modern
 :config
(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
:ensure t)

;; Must do this so the agenda knows where to look for my files
(setq org-agenda-files '("~/org"))

;; When a TODO is set to a done state, record a timestamp
(setq org-log-done 'time)

;; Follow the links
(setq org-return-follows-link  t)

;; Associate all org files with org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Make the indentation look nicer
(add-hook 'org-mode-hook 'org-indent-mode)

;; Remap the change priority keys to use the UP or DOWN key
(define-key org-mode-map (kbd "C-c <up>") 'org-priority-up)
(define-key org-mode-map (kbd "C-c <down>") 'org-priority-down)

;; Shortcuts for storing links, viewing the agenda, and starting a capture
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

;; When you want to change the level of an org item, use SMR
(define-key org-mode-map (kbd "C-c C-g C-r") 'org-shiftmetaright)

;; Hide the markers so you just see bold text as BOLD-TEXT and not *BOLD-TEXT*
(setq org-hide-emphasis-markers t)

;; Wrap the lines in org mode so that things are easier to read
(add-hook 'org-mode-hook 'visual-line-mode)

(when window-system
  (let* ((variable-tuple
          (cond ((x-list-fonts "CartographCF Nerd Font")         '(:font "CartographCF Nerd Font" :foreground "#FFF"))
                ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                ((x-list-fonts "Verdana")         '(:font "Verdana"))
                ((x-list-fonts "Sans Serif")    '(:family "Sans Serif"))
                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
         (base-font-color     (face-foreground 'default nil 'default))
         (headline           `(:inherit default :weight bold :foreground ,base-font-color)))
    (custom-theme-set-faces
     'user
     `(org-level-8 ((t (,@headline ,@variable-tuple))))
     `(org-level-7 ((t (,@headline ,@variable-tuple))))
     `(org-level-6 ((t (,@headline ,@variable-tuple))))
     `(org-level-5 ((t (,@headline ,@variable-tuple))))
     `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.2))))
     `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.3))))
     `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.4))))
     `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.5))))
     `(org-document-title ((t (,@headline ,@variable-tuple :height 1.7 :underline nil))))))
)


  (use-package org-super-agenda
    :ensure t)

(use-package comment-tags
 :ensure t)

(setq org-capture-templates
     '(
       ("j" "Work Log Entry"
        entry (file+datetree "~/org/work-log.org")
        "* %?"
        :empty-lines 0)

       ("n" "Note"
        entry (file+headline "~/org/notes.org" "Random Notes")
        "** %?"
        :empty-lines 0)

       ("g" "General To-Do"
        entry (file+headline "~/org/todos.org" "General Tasks")
        "* TODO [#B] %?\n:Created: %T\n "
        :empty-lines 0)
       ))

;; TODO states
(setq org-todo-keywords
     '((sequence "TODO(t)" "PLANNING(p)" "IN-PROGRESS(i@/!)" "VERIFYING(v!)" "BLOCKED(b@)"  "|" "DONE(d!)" "OBE(o@!)" "WONT-DO(w@/!)" )
       ))

(use-package powerline-evil
 :ensure t)
(powerline-evil-vim-theme)
(powerline-evil-vim-color-theme)
(define-key evil-ex-map "e" 'find-file)
(define-key evil-ex-map "W" 'save-buffer)

(use-package company
 :ensure t
 :init
 (setq company-require-match nil            ; Don't require match, so you can still move your cursor as expected.
       company-tooltip-align-annotations t  ; Align annotation to the right side.
       company-eclim-auto-save nil          ; Stop eclim auto save.
       company-dabbrev-downcase nil
       company-idle-delay 0.2)        ; No downcase when completion.
 :config
 (global-company-mode t))

(use-package which-key
 :config
 (setq which-key-idle-delay 0.3)
 (setq which-key-popup-type 'frame)
 (which-key-mode)
 (which-key-setup-minibuffer)
 (set-face-attribute 'which-key-local-map-description-face nil
                     :weight 'bold)
 :ensure t)

(use-package magit
 :ensure t
 :bind ("C-x g" . magit-status))

(use-package paredit
 :ensure t
 :init
 (add-hook 'clojure-mode-hook #'enable-paredit-mode)
 (add-hook 'cider-repl-mode-hook #'enable-paredit-mode)
 (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
 (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
 (add-hook 'ielm-mode-hook #'enable-paredit-mode)
 (add-hook 'lisp-mode-hook #'enable-paredit-mode)
 (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
 (add-hook 'scheme-mode-hook #'enable-paredit-mode)
 :config
 (show-paren-mode t)
 :bind (("M-[" . paredit-wrap-square)
        ("M-{" . paredit-wrap-curly))
 :diminish nil)

(use-package yasnippet
 :ensure t
 :config
 (yas-global-mode 1))


(use-package all-the-icons
 :if (display-graphic-p)
 :ensure t)

(use-package company-fuzzy
 :hook (company-mode . company-fuzzy-mode)
 :init
 (setq company-fuzzy-sorting-backend 'flx
       company-fuzzy-prefix-on-top nil
       company-fuzzy-trigger-symbols '("." "->" "<" "\"" "'" "@")))

;; other configs

(global-hl-line-mode t) ;; This highlights the current line in the buffer
(use-package beacon ;; This applies a beacon effect to the highlighted line
 :ensure t
 :config
 (beacon-mode 1))

;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   (load-theme 'doom-sourcerer t)

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;;   (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))

(use-package kaolin-themes
 :ensure t
 :config
 (load-theme 'kaolin-dark t)
 (kaolin-treemacs-theme))

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(use-package projectile
 :ensure t
 :init
 (projectile-mode +1)
 :bind (:map projectile-mode-map
             ("C-c p" . projectile-command-map))
 :config
 (setq projectile-project-search-path '("~/repos/" "~/work/" )))

;; keybindings

(global-set-key (kbd "M-<") 'previous-buffer)
(global-set-key (kbd "M->") 'next-buffer)
(evil-set-leader nil (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>pv")
 (lambda () (interactive) (dired default-directory)))
(evil-define-key 'visual 'global (kbd "J") 'evil-collection-unimpaired-move-text-down)
(evil-define-key 'visual 'global (kbd "K") 'evil-collection-unimpaired-move-text-up)
 ;; helm
 (use-package helm
   :ensure t
   :config
   (helm-mode 1)
   (global-set-key (kbd "C-x b") 'helm-buffers-list)
   (global-set-key (kbd "C-x r b") 'helm-boormarks)
   (global-set-key (kbd "C-x C-f") 'helm-find-files)
   (global-set-key (kbd "M-c") 'helm-calcul-expression)
   (global-set-key (kbd "C-x b") 'helm-buffers-list)
   (global-set-key (kbd "C-s") 'helm-occur)
   (global-set-key (kbd "M-x") 'helm-M-x)
   (global-set-key (kbd "M-y") 'helm-show-kill-ring)
   (global-set-key (kbd "C-h a") 'helm-apropos)
   (setq helm-split-window-in-side-p t
         helm-move-to-line-cycle-in-source t))

(use-package helm-projectile
  :ensure t)

(evil-define-key 'normal 'global (kbd "<leader>sf")
  (lambda () (interactive) (helm-projectile)))
(evil-define-key 'normal 'global (kbd "<leader>mc")
  (lambda () (interactive) (find-file user-init-file)))

(electric-pair-mode 1)

(use-package eaf
  :load-path "~/.emacs.d/site-lisp/emacs-application-framework"
  :custom
  ; See https://github.com/emacs-eaf/emacs-application-framework/wiki/Customization
  (eaf-browser-continue-where-left-off t)
  (eaf-browser-enable-adblocker t)
  (browse-url-browser-function 'eaf-open-browser)
  :config
  (defalias 'browse-web #'eaf-open-browser))

(require 'eaf-browser)
(require 'eaf-pdf-viewer)
