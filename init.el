; Add melpa package-archive
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

; Set Iosevka as the default font
(add-to-list 'default-frame-alist
             '(font . "Iosevka NF-16"))

;; Remove GUI components
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)

(setq display-line-numbers-type 'relative)
(setq inhibit-startup-screen t)
(setq org-log-done 'time)
(setq vc-follow-symlinks t)

;; (load-theme 'modus-operandi :no-confirm)
(load-theme 'modus-vivendi :no-confirm)

;; Vim emulation
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :custom
  (evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; Vertico - Minibuffer.
(use-package vertico
  :ensure t
  :custom
  (vertico-count 15) ;; Show more candidates
  :init
  (vertico-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Emacs minibuffer configurations.
(use-package emacs
  :custom
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))
 
(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  ;; trigger completion
  (define-key evil-insert-state-map (kbd "C-SPC")
    #'company-complete)
  ;; accept completion
  (define-key company-active-map (kbd "C-y")
    #'company-complete-selection))

 (use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

 (use-package yasnippet
  :ensure t
  :custom
  (yas-global-mode 1))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(markdown-mode . ("markdown-oxide")))
  (add-to-list 'eglot-server-programs
               '(lua-ts-mode .  ("lua-language-server"))))

(use-package lua-ts-mode
  :mode "\\.lua\\'"
  :hook (lua-ts-mode . eglot-ensure))

(use-package markdown-mode
  :ensure t
  :hook (markdown-mode . eglot-ensure))

(use-package magit
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
