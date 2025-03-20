;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq shell-file-name (executable-find "bash"))
(setq-default term-shell (executable-find "fish"))

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font "DaddyTimeMono Nerd Font-15")
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; (setq doom-theme 'doom-horizon)
(setq doom-theme 'doom-rouge)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; https://superuser.com/questions/271023/can-i-disable-continuation-of-comments-to-the-next-line-in-vim
(setq +evil-want-o/O-to-continue-comments nil)

(global-set-key (kbd "M-<") 'previous-buffer)
(global-set-key (kbd "M->") 'next-buffer)

;; Custom function to handle double comma
(defvar my-last-comma-time nil
  "Timestamp of the last `,' press.")

(defun my-insert-comma-or-emmet ()
  (interactive)
  (let ((now (current-time)))
    (if (and my-last-comma-time
             (< (float-time (time-subtract now my-last-comma-time)) 0.2)) ; 0.3s threshold
        (progn
          (delete-char -1) ; Delete the first comma
          (emmet-expand-line nil)) ; Trigger Emmet
      (insert ",") ; Insert a single comma
      (setq my-last-comma-time now)))) ; Update timestamp

;; Bind to comma in Evil insert mode
(after! evil
  (define-key evil-insert-state-map (kbd ",") #'my-insert-comma-or-emmet))

;; Ensure vterm is loaded
(use-package! vterm
  :commands vterm
  :config
  (setq vterm-kill-buffer-on-exit t)) ; Auto-kill buffer on exit

(after! vterm
  (setq vterm-shell "fish")); Replace "fish" with the path to your Fish binary if needed)

;; Function to open lazygit in a split
;; (defun +lazygit-in-project ()
;;   "Open lazygit in a vterm buffer at the project root."
;;   (interactive)
;;   (let ((default-directory (doom-project-root)))
;;     (message "Opening lazygit in %s" default-directory)
;;     ;; Open in a side window (adjust height as needed)
;;     (pop-to-buffer
;;      (generate-new-buffer "*lazygit*")
;;      '((display-buffer-in-side-window)
;;        (side . bottom)
;;        (window-height . 0.5)))
;;     ;; Start vterm and run lazygit
;;     (vterm-mode)
;;     (vterm-send-string "lazygit")
;;     (vterm-send-return)))

(defun +lazygit-in-project ()
  "Open lazygit in a floating frame and auto-close on exit."
  (interactive)
  (let* ((default-directory (doom-project-root))
         ;; Create a new floating frame
         (frame (make-frame `((name . "lazygit")
                              (width . 120)
                              (height . 30)
                              (minibuffer . nil)
                              (left . 0.5)    ; Center horizontally
                              (top . 0.5)     ; Center vertically
                              (transient . t) ; Mark as temporary
                              (no-accept-focus . t))))
         ;; Create a dedicated buffer
         (buffer (generate-new-buffer "*lazygit*")))
    ;; Configure the new frame and buffer
    (select-frame frame)
    (switch-to-buffer buffer)
    (vterm-mode)
    ;; Launch lazygit
    (vterm-send-string "lazygit")
    (vterm-send-return)
    ;; Bind 'q' to kill buffer and frame
    (define-key vterm-mode-map (kbd "q")
                (lambda ()
                  (interactive)
                  (kill-buffer buffer)
                  (delete-frame frame)))
    ;; Auto-close frame when process dies (e.g., lazygit exits)
    (let ((proc (get-buffer-process buffer)))
      (when proc
        (set-process-sentinel proc
                              (lambda (proc _event)
                                (when (memq (process-status proc) '(exit signal))
                                  (kill-buffer buffer)
                                  (delete-frame frame))))))))

(map! :leader :n "g g" #'+lazygit-in-project)
(map! :leader
      :desc "Search by grep"  ; This description shows in which-key popups
      "r g" #'consult-ripgrep)

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word))
  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(closure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

(after! (evil copilot)
  ;; Define the custom function that either accepts the completion or does the default behavior
  (defun my/copilot-tab-or-default ()
    (interactive)
    (if (and (bound-and-true-p copilot-mode)
             ;; Add any other conditions to check for active copilot suggestions if necessary
             )
        (copilot-accept-completion)
      (evil-insert 1))) ; Default action to insert a tab. Adjust as needed.

  ;; Bind the custom function to <tab> in Evil's insert state
  (evil-define-key 'insert 'global (kbd "<tab>") 'my/copilot-tab-or-default))

;; (add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

(defun kb/toggle-window-transparency (arg)
  "Toggle the value of `alpha-background'.

Toggles between 100 and 78 by default.
If called with ARG (via C-u or numeric input), asks the user which value to set."
  (interactive "P")
  (let ((transparency
         (cond
          ((numberp arg) arg)
          (arg (read-number "Change the transparency to which value (0-100)? "))
          (t (pcase (frame-parameter nil 'alpha-background)
               (78 100)
               (100 78)
               (_ 78))))))
    (set-frame-parameter nil 'alpha-background transparency)
    (message "Transparency set to %s" transparency)))

;; Bind to M-S-t (which is written as M-T in Emacs)
(global-set-key (kbd "M-T") #'kb/toggle-window-transparency)

;; set default org img inline
(setq org-startup-with-inline-images t)

(defun my/org-download-image-smart ()
  "Download image to ./images/ and insert as Org link.
Priority:
1. URL under point (on a link)
2. Last yanked URL (from kill-ring)
3. Prompt user for URL"
  (interactive)
  (let* ((img-dir "images")  ;; Path relative to your Org file
         (url
          (or
           ;; Case 1: URL under point if it's a link
           (when-let ((context (org-element-context)))
             (when (eq (car context) 'link)
               (org-element-property :raw-link context)))
           ;; Case 2: Check if kill-ring has a URL
           (cl-find-if (lambda (s) (string-match-p "^https?://" s)) kill-ring)
           ;; Case 3: Prompt the user
           (read-string "Image URL: ")))
         ;; Extract extension (fallback to png)
         (ext (or (file-name-extension url) "png"))
         (filename (concat (format-time-string "%Y%m%d-%H%M%S") "." ext))
         ;; Calculate relative filepath from current Org file's directory
         (filepath (expand-file-name filename img-dir))
         (relative-path (file-relative-name filepath (file-name-directory (buffer-file-name)))))
    (unless (file-exists-p img-dir)
      (make-directory img-dir))
    (url-copy-file url filepath t)
    (insert (format "[[file:%s]]" relative-path))
    (org-display-inline-images)))


(map! :leader
      :desc "Download image to repo"
      "m i d" #'my/org-download-image-smart)


;; LATEX
;; Set Tectonic as the default LaTeX engine
(setq TeX-engine 'tectonic)

(setq org-latex-compiler "tectonic")

(setq org-latex-pdf-process
      '("tectonic %f"))
