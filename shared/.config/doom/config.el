;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq lsp-use-plists t)
(setq shell-file-name (executable-find "bash"))
(setq-default term-shell (executable-find "fish"))
(setenv "LSP_USE_PLISTS" "true")
(setq read-process-output-max (* 10 1024 1024)) ;; 10mb
(setq gc-cons-threshold 200000000)
(setq lsp-idle-delay 0.500)
(setq lsp-log-io nil) ; if set to true can cause a performance hit

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
(setq doom-font "Iosevka Nerd Font-18")
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; (setq doom-theme 'doom-horizon)
;; (setq doom-theme 'doom-rouge)
;; (setq doom-theme 'kaolin-dark)

;; pywal!!

(use-package! ewal
  :init
  (setq ewal-use-built-in-always-p nil
        ewal-use-built-in-on-failure-p t
        ewal-built-in-palette "sexy-material"))

(use-package! ewal-spacemacs-themes
  :init
  (setq spacemacs-theme-underline-parens t
        my:rice:font (font-spec :family "Iosevka Nerd Font"
                                :weight 'semi-bold
                                :size 18.0))
  (show-paren-mode 1)
  (global-hl-line-mode 1)
  (set-frame-font my:rice:font nil t)
  (add-to-list 'default-frame-alist `(font . ,(font-xlfd-name my:rice:font)))
  :config
  (load-theme 'ewal-spacemacs-modern t)
  (enable-theme 'ewal-spacemacs-modern))

(use-package! ewal-evil-cursors
  :after ewal-spacemacs-themes
  :config
  (ewal-evil-cursors-get-colors :apply t :spaceline t))

(use-package! spaceline
  :after (ewal-evil-cursors winum)
  :init
  (setq powerline-default-separator nil)
  :config
  (spaceline-spacemacs-theme))



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
(global-set-key (kbd "M-X") 'doom/kill-this-buffer-in-all-windows)
(global-set-key (kbd "M-<") 'projectile-previous-project-buffer)
(global-set-key (kbd "M->") 'projectile-next-project-buffer)

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
      "r g" #'+default/search-project)

;; accept completion from copilot and fallback to company
(use-package! copilot
  ;; :hook (prog-mode . copilot-mode)
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
             (not (eq major-mode 'erc-mode))) ; Exclude ERC mode
        (copilot-accept-completion)
      (call-interactively (key-binding (kbd "TAB")))))

  ;; Bind the custom function to <tab> in Evil's insert state
  (evil-define-key 'insert 'global (kbd "<tab>") 'my/copilot-tab-or-default))


;; (add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

(defun kb/toggle-window-transparency (arg)
  "Toggle the value of `alpha-background'.

Toggles between 100 and 85 by default.
If called with ARG (via C-u or numeric input), asks the user which value to set."
  (interactive "P")
  (let ((transparency
         (cond
          ((numberp arg) arg)
          (arg (read-number "Change the transparency to which value (0-100)? "))
          (t (pcase (frame-parameter nil 'alpha-background)
               (95 100)
               (100 95)
               (_ 95))))))
    (set-frame-parameter nil 'alpha-background transparency)
    (message "Transparency set to %s" transparency)))

;; Bind to M-S-t (which is written as M-T in Emacs)
(global-set-key (kbd "M-T") #'kb/toggle-window-transparency)

;; also set it defaultly
(set-frame-parameter nil 'alpha-background 90)


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
    (insert (format "[[file:%s]]" relative-path))))


(map! :leader
      :desc "Download image to repo"
      "m i d" #'my/org-download-image-smart)


;;;;;; LATEX

;; latex-mode
(setq tex-command "tectonic -X compile")

(defun tex-compile-and-open-with-zathura ()
  "Compile the current TeX file using tectonic and open the PDF with Zathura."
  (interactive)
  (save-buffer)
  (let* ((tex-file (buffer-file-name))
         (pdf-file (concat (file-name-sans-extension tex-file) ".pdf"))
         (exit-code (call-process "tectonic" nil "*Tectonic Output*" t tex-file)))
    (if (eq exit-code 0)
        (progn
          (message "Compilation successful, opening PDF...")
          (start-process "zathura" nil "zathura" pdf-file))
      (progn
        (switch-to-buffer "*Tectonic Output*")
        (message "Compilation failed. See *Tectonic Output* for details.")))))


(add-hook 'tex-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-c") #'tex-compile-and-open-with-zathura)))

;; auctex
(setq auto-mode-alist
      (append '(("\\.tex\\'" . LaTeX-mode)) auto-mode-alist))

;; this works
(require 'tex)
(setq TeX-save-query nil
      TeX-show-compilation t)

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-to-list 'TeX-command-list
                         '("Tectonic" "tectonic %t && zathura %s.pdf" TeX-run-command t t :help "Run Tectonic"))
            (setq TeX-command-default "Tectonic")
            (setq TeX-view-program-selection '((output-pdf "Zathura")))
            (setq TeX-view-program-list '(("Zathura" "zathura %o")))))

(after! tex
  (add-hook 'TeX-after-compilation-finished-functions
            (lambda (_)
              (TeX-view))))


;; org latex

;; Configure Org mode to use Tectonic for LaTeX export
(after! ox-latex
  (setq org-latex-compiler "tectonic")
  (add-to-list 'org-latex-packages-alist '("" "listings"))
  (add-to-list 'org-latex-packages-alist '("" "color"))
  (add-to-list 'org-latex-packages-alist '("svgnames" "xcolor" t))
  (add-to-list 'org-latex-packages-alist '("" "textcomp" t))

  (setq org-latex-listings-options
        '(("basicstyle" . "\\footnotesize\\ttfamily")
          ("keywordstyle" . "\\color{RoyalBlue}\\bfseries")
          ("commentstyle" . "\\color{ForestGreen}\\itshape")
          ("stringstyle" . "\\color{purple}")
          ("numberstyle" . "\\tiny\\color{Gray}")
          ("backgroundcolor" . "\\color{LightGray!15}")
          ("frame" . "tb")
          ("breaklines" . "true")
          ("showstringspaces" . "false")
          ("tabsize" . "2")
          ("upquote" . "true")
          ("captionpos" . "b")
          ("numbers" . "left")
          ("identifierstyle" . "")))
  (setq org-latex-src-block-backend 'listings)

  (setq org-latex-pdf-process
        '("tectonic -Z shell-escape %f")))

;; Set Zathura as the default PDF viewer
(setq org-file-apps
      '((auto-mode . emacs)
        ("\\.pdf\\'" . "zathura %s")
        ("\\.x?html?\\'" . default)))

;; pt br
(after! ox-latex
  (setq org-export-default-language "pt-br")
  (add-to-list 'org-latex-packages-alist
               '("AUTO" "babel" t ("pdflatex" "xelatex" "lualatex"))))

;; set default project path
(setq projectile-project-search-path '(("~/proprietary/" . 2)))

;; erc znc
(require 'znc)

(setq znc-servers
      `(("irc.jabuxas.com" 6697 t
         ((libera
           "jabuxas/libera"
           ,(auth-source-pick-first-password :host "irc.jabuxas.com" :user "jabuxas/libera"))
          (oftc
           "jabuxas/oftc"
           ,(auth-source-pick-first-password :host "irc.jabuxas.com" :user "jabuxas/oftc"))
          (mam
           "jabuxas/mam"
           ,(auth-source-pick-first-password :host "irc.jabuxas.com" :user "jabuxas/mam"))))))

(after! erc
  (define-key erc-mode-map (kbd "C-c C-s") #'erc-track-switch-buffer))

;; osd erc
(load! "modules/doom-erc-notifications")

(after! hydra
  (defun get-project-compile-commands ()
    "Get compile commands from .dir-locals.el"
    (when-let ((commands (cdr (assoc 'project-compile-commands (or dir-local-variables-alist
                                                                   (hack-dir-local-variables-apply))))))
      commands))

  (defun run-project-command-async (command name)
    "Run a compile command asynchronously from the project root in a unique buffer"
    (interactive)
    (let ((default-directory (projectile-project-root))
          (compilation-buffer-name-function
           (lambda (_) (format "*compilation-%s*" name))))
      (compile command t)))

  (defhydra hydra-project-compile (:color blue :hint nil)
    "
        Project Compile Commands
        -----------------------
    "
    ("q" nil "quit")
    ;; Dynamic heads will be added below
    )

  (defun call-hydra-project-compile ()
    "Create and call a hydra with project compile commands"
    (interactive)
    (let ((commands (get-project-compile-commands)))
      (if (not commands)
          (message "No project compile commands found in .dir-locals.el")
        ;; Create a new hydra definition with the commands
        (eval
         `(defhydra hydra-project-compile (:color blue :hint nil)
            "
Project Compile Commands
-----------------------
"
            ,@(mapcar (lambda (cmd-pair)
                        (let ((name (car cmd-pair))
                              (cmd (cdr cmd-pair)))
                          `(,(substring name 0 1) (run-project-command-async ,cmd ,name) ,name)))
                      commands)
            ("q" nil "quit")))
        (hydra-project-compile/body))))

  ;; Bind the hydra to a key
  (map! :leader
        :desc "Project compile commands" "c p" #'call-hydra-project-compile)
  (setq enable-local-variables :safe))


(after! drag-stuff
  (drag-stuff-global-mode 1)
  (define-key evil-visual-state-map (kbd "K") #'drag-stuff-up)
  (define-key evil-visual-state-map (kbd "J") #'drag-stuff-down))

(setq org-startup-with-inline-images nil)

(setq history-length 100)
(put 'minibuffer-history 'history-length 50)
(put 'evil-ex-history 'history-length 50)
(put 'kill-ring 'history-length 25)

(after! epg
  (setq epg-pinentry-mode 'loopback))

(after! pinentry
  (pinentry-start))


(drag-stuff-global-mode 1)
(minimap-mode 1)
(flycheck-popup-tip-mode 1)

(map! :n "C-e" #'+treemacs/toggle)

;; (after! lsp-mode
;;   (setq lsp-volar-take-over-mode nil)
;;   (setq lsp-volar-hybrid-mode t))


;; https://emacs.stackexchange.com/questions/71436/undo-tree-changed-treemacs-layout-when-move-history-cursor-in-spacemacs
(with-eval-after-load 'undo-tree

  ;; [2023-10-20 Fri] modify this function from undo-tree.el to prevent
  ;; re-balancing windows ------------------------------------------------------
  (defun undo-tree-visualizer-update-diff (&optional node)
    ;; update visualizer diff display to show diff between current state and
    ;; NODE (or previous state, if NODE is null)
    (with-current-buffer undo-tree-visualizer-parent-buffer
      (undo-tree-diff node))
    (let ((win (get-buffer-window undo-tree-diff-buffer-name)))
      (when win
        ;; (balance-windows); comment this line out
        (shrink-window-if-larger-than-buffer win))))
  )

(defun blend-colors (fg bg alpha)
  "Blend FG and BG hex colors by ALPHA (0.0-1.0)."
  (cl-labels ((hex-to-rgb (hex)
                (mapcar (lambda (x) (/ (float x) 255))
                        (list (string-to-number (substring hex 1 3) 16)
                              (string-to-number (substring hex 3 5) 16)
                              (string-to-number (substring hex 5 7) 16)))))
    (let* ((fg-rgb (hex-to-rgb fg))
           (bg-rgb (hex-to-rgb bg))
           (blend (cl-mapcar (lambda (f b) (+ (* alpha f) (* (- 1 alpha) b)))
                             fg-rgb bg-rgb)))
      (format "#%02x%02x%02x"
              (floor (* 255 (nth 0 blend)))
              (floor (* 255 (nth 1 blend)))
              (floor (* 255 (nth 2 blend)))))))


(after! ewal
  (let* ((fg (ewal-get-color 'magenta))
         (bg (ewal-get-color 'background))
         (blend-color (blend-colors fg bg 0.3))) ;; 50% alpha
    (custom-set-faces!
      `(minimap-active-region-background :background ,blend-color))))

(defun uv-activate ()
  "Activate Python environment managed by uv based on current project directory.
Looks for .venv directory in project root and activates the Python interpreter."
  (interactive)
  (let* ((project-root (project-root (project-current t)))
         (venv-path (expand-file-name ".venv" project-root))
         (python-path (expand-file-name
                       (if (eq system-type 'windows-nt)
                           "Scripts/python.exe"
                         "bin/python")
                       venv-path)))
    (if (file-exists-p python-path)
        (progn
          ;; Set Python interpreter path
          (setq python-shell-interpreter python-path)

          ;; Update exec-path to include the venv's bin directory
          (let ((venv-bin-dir (file-name-directory python-path)))
            (setq exec-path (cons venv-bin-dir
                                  (remove venv-bin-dir exec-path))))

          ;; Update PATH environment variable
          (setenv "PATH" (concat (file-name-directory python-path)
                                 path-separator
                                 (getenv "PATH")))

          ;; Update VIRTUAL_ENV environment variable
          (setenv "VIRTUAL_ENV" venv-path)

          ;; Remove PYTHONHOME if it exists
          (setenv "PYTHONHOME" nil)

          (message "Activated UV Python environment at %s" venv-path))
      (error "No UV Python environment found in %s" project-root))))


(use-package! uv-mode
  :hook (python-mode . uv-mode-auto-activate-hook))

(use-package treesit
  :mode (("\\.tsx\\'" . tsx-ts-mode)
         ("\\.js\\'"  . typescript-ts-mode)
         ("\\.mjs\\'" . typescript-ts-mode)
         ("\\.mts\\'" . typescript-ts-mode)
         ("\\.cjs\\'" . typescript-ts-mode)
         ("\\.ts\\'"  . typescript-ts-mode)
         ("\\.jsx\\'" . tsx-ts-mode)
         ("\\.json\\'" .  json-ts-mode)
         ("\\.Dockerfile\\'" . dockerfile-ts-mode)
         ("\\.prisma\\'" . prisma-ts-mode)
         ;; More modes defined here...
         )
  :preface
  (defun os/setup-install-grammars ()
    "Install Tree-sitter grammars if they are absent."
    (interactive)
    (dolist (grammar
             '((css . ("https://github.com/tree-sitter/tree-sitter-css" "v0.20.0"))
               (bash "https://github.com/tree-sitter/tree-sitter-bash")
               (html . ("https://github.com/tree-sitter/tree-sitter-html" "v0.20.1"))
               (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript" "v0.21.2" "src"))
               (json . ("https://github.com/tree-sitter/tree-sitter-json" "v0.20.2"))
               (python . ("https://github.com/tree-sitter/tree-sitter-python" "v0.20.4"))
               (go "https://github.com/tree-sitter/tree-sitter-go" "v0.20.0")
               (markdown "https://github.com/ikatyang/tree-sitter-markdown")
               (make "https://github.com/alemuller/tree-sitter-make")
               (elisp "https://github.com/Wilfred/tree-sitter-elisp")
               (cmake "https://github.com/uyha/tree-sitter-cmake")
               (c "https://github.com/tree-sitter/tree-sitter-c")
               (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
               (toml "https://github.com/tree-sitter/tree-sitter-toml")
               (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src"))
               (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src"))
               (yaml . ("https://github.com/ikatyang/tree-sitter-yaml" "v0.5.0"))
               (prisma "https://github.com/victorhqc/tree-sitter-prisma")))
      (add-to-list 'treesit-language-source-alist grammar)
      ;; Only install `grammar' if we don't already have it
      ;; installed. However, if you want to *update* a grammar then
      ;; this obviously prevents that from happening.
      (unless (treesit-language-available-p (car grammar))
        (treesit-install-language-grammar (car grammar)))))

  ;; Optional, but recommended. Tree-sitter enabled major modes are
  ;; distinct from their ordinary counterparts.
  ;;
  ;; You can remap major modes with `major-mode-remap-alist'. Note
  ;; that this does *not* extend to hooks! Make sure you migrate them
  ;; also
  (dolist (mapping
           '((python-mode . python-ts-mode)
             (css-mode . css-ts-mode)
             (typescript-mode . typescript-ts-mode)
             (js-mode . typescript-ts-mode)
             (js2-mode . typescript-ts-mode)
             (c-mode . c-ts-mode)
             (c++-mode . c++-ts-mode)
             (c-or-c++-mode . c-or-c++-ts-mode)
             (bash-mode . bash-ts-mode)
             (css-mode . css-ts-mode)
             (json-mode . json-ts-mode)
             (js-json-mode . json-ts-mode)
             (sh-mode . bash-ts-mode)
             (sh-base-mode . bash-ts-mode)))
    (add-to-list 'major-mode-remap-alist mapping))
  :config
  (os/setup-install-grammars))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :bind (:map flycheck-mode-map
              ("M-n" . flycheck-next-error) ; optional but recommended error navigation
              ("M-p" . flycheck-previous-error)))

(use-package lsp-eslint
  :demand t
  :after lsp-mode)

(use-package! lsp-tailwindcss
  :init
  (setq lsp-tailwindcss-add-on-mode t)
  :config
  (dolist (mode '(css-mode css-ts-mode typescript-mode typescript-ts-mode
                  tsx-ts-mode js2-mode js-ts-mode clojure-mode))
    (add-to-list 'lsp-tailwindcss-major-modes mode)))

(add-hook 'tsx-ts-mode-hook #'lsp-deferred)
(add-hook 'typescript-ts-mode-hook #'lsp-deferred)
(add-hook 'js-ts-mode-hook #'lsp-deferred)

(use-package! lsp-mode
  :init
  (setq lsp-use-plists t)

  :config
  (defun lsp-booster--advice-json-parse (old-fn &rest args)
    "Try to parse bytecode instead of json."
    (or
     (when (equal (following-char) ?#)
       (let ((bytecode (read (current-buffer))))
         (when (byte-code-function-p bytecode)
           (funcall bytecode))))
     (apply old-fn args)))

  (defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
    "Prepend emacs-lsp-booster command to lsp CMD."
    (let ((orig-result (funcall old-fn cmd test?)))
      (if (and (not test?)                             ;; for check lsp-server-present?
               (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
               lsp-use-plists
               (executable-find "emacs-lsp-booster"))
          (progn
            (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
              (setcar orig-result command-from-exec-path))
            (message "Using emacs-lsp-booster for %s!" orig-result)
            (cons "emacs-lsp-booster" orig-result))
        orig-result)))

  ;; Add the advice. This runs after lsp-mode is loaded.
  (advice-add (if (fboundp 'json-parse-buffer) 'json-parse-buffer 'json-read)
              :around #'lsp-booster--advice-json-parse)
  (advice-add 'lsp-resolve-final-command
              :around #'lsp-booster--advice-final-command))
