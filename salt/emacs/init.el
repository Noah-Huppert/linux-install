;;;;;;;;;;;;;;
; Emacs Core ;
;;;;;;;;;;;;;;

; Local plugins
(add-to-list 'load-path "{{ pillar.emacs.plugins_load_path }}")

; Initialize package manager
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize) 

; Save all backup files in a dedicated directory
; https://stackoverflow.com/a/2680682
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
)

; Enable syntax highlighting
(global-font-lock-mode t)

;;;;;;;;;;;;
; Behavior ;
;;;;;;;;;;;;


; Show line numbers
(global-display-line-numbers-mode)

; Max line length
(require 'column-marker)
(add-hook 'text-mode-hook (lambda () (interactive) (column-marker-3 80)))

; Enable VIM keybindings
(require 'evil)
(evil-mode t)

; Spell check
(add-hook 'text-mode-hook 'flyspell-mode)
