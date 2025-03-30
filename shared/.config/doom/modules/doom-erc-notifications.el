;;; doom-erc-notifications.el --- Simple ERC notifications for Doom Emacs

;; Basic notification function using notify-send
(defun my/notify-send (title message)
  "Send desktop notification with TITLE and MESSAGE using notify-send."
  (start-process "notify-send" nil
                 "notify-send"
                 "--app-name=ERC"
                 "--expire-time=5000"
                 title
                 message))

;; The main notification function for ERC
(defun my/erc-notify (nick channel message)
  "Send notification for message from NICK in CHANNEL with MESSAGE."
  (unless (string= nick (erc-current-nick))
    (my/notify-send
     (format "ERC: %s in %s" nick channel)
     message)))

;; Handle notifications for matched text
(defun my/erc-matched-hook (match-type nickuserhost message)
  "Process matched messages for notifications.
Triggered on MATCH-TYPE from NICKUSERHOST with MESSAGE."
  (when (or (string= match-type "current-nick")
            (string= match-type "keyword"))
    (my/erc-notify
     (erc-extract-nick nickuserhost)
     (buffer-name)
     message)))

;; Setup function to be called after ERC is loaded
(defun my/setup-erc-notifications ()
  "Set up ERC notifications."
  (interactive)
  ;; Make sure erc-match-mode is enabled
  (require 'erc-match)
  (erc-match-mode 1)

  ;; Add our hook to erc-text-matched-hook
  (add-hook 'erc-text-matched-hook #'my/erc-matched-hook)

  (message "ERC notifications set up successfully!"))

;; Set up everything when ERC is loaded
(after! erc
  (my/setup-erc-notifications))

;; Command to manually set up notifications if needed
(defalias 'erc-notifications-setup 'my/setup-erc-notifications)

;; Export the setup function
(provide 'doom-erc-notifications)
;;; doom-erc-notifications.el ends here
