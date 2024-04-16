(setq inhibit-startup-message t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
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
  (evil-mode 1))

(use-package org
  :ensure t)

(use-package powerline-evil
  :ensure t)
(powerline-evil-vim-theme)
(powerline-evil-vim-color-theme)
(define-key evil-ex-map "e" 'find-file)
(define-key evil-ex-map "W" 'save-buffer)

(use-package company
  :ensure t)

(use-package which-key
  :config
    (setq which-key-idle-delay 0.3)
    (setq which-key-popup-type 'frame)
    (which-key-mode)
    (which-key-setup-minibuffer)
    (set-face-attribute 'which-key-local-map-description-face nil
       :weight 'bold)
  :ensure t)

(use-package company-fuzzy
  :hook (company-mode . company-fuzzy-mode)
  :init
  (setq company-fuzzy-sorting-backend 'flx
        company-fuzzy-prefix-on-top nil
        company-fuzzy-trigger-symbols '("." "->" "<" "\"" "'" "@")))

(use-package eglot
  :ensure t)

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

;; setup go
(require 'project)

(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)

(require 'go-mode)
(require 'eglot)
(add-hook 'go-mode-hook 'eglot-ensure)

;; Optional: install eglot-format-buffer as a save hook.
;; The depth of -10 places this before eglot's willSave notification,
;; so that that notification reports the actual contents that will be saved.
 (defun eglot-format-buffer-on-save ()
  (add-hook 'before-save-hook #'eglot-format-buffer -10 t))
(add-hook 'go-mode-hook #'eglot-format-buffer-on-save)

(add-hook 'before-save-hook
    (lambda ()
        (call-interactively 'eglot-code-action-organize-imports))
    nil t)

;; other configs

(global-hl-line-mode t) ;; This highlights the current line in the buffer
(use-package beacon ;; This applies a beacon effect to the highlighted line
   :ensure t
   :config
   (beacon-mode 1))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-homage-black t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; keybindings

(global-set-key (kbd "M-<") 'previous-buffer)
(global-set-key (kbd "M->") 'next-buffer)
(evil-set-leader nil (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>pv")
  (lambda () (interactive) (dired default-directory)))


(set-frame-font "CartographCF Nerd Font DemiBold 14" nil t)


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
