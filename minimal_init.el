;; -*- lexical-binding: t; -*-


;;; ============================================================
;;; CORE
;;; ============================================================

;; Usa UTF-8 come codifica predefinita
(prefer-coding-system 'utf-8-unix)

;; Non mostrare la schermata di benvenuto
(setq inhibit-startup-screen t)

;; Risposte brevi: y/n invece di yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Disabilita il beep
(setq ring-bell-function #'ignore)

(setq frame-title-format "GNU Emacs")
(setq icon-title-format "GNU Emacs")
;;; ============================================================
;;; UI
;;; ============================================================
(require 'org-tempo)
(setq confirm-kill-processes nil)
(setq confirm-kill-emacs nil)

;; Interfaccia minimale
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Mostra numero di riga e colonna
(line-number-mode 1)
(column-number-mode 1)

;; Vai a capo visivamente sulle righe lunghe
(global-visual-line-mode 1)

;; Non mostrare la schermata di benvenuto
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message user-login-name)

;; Buffer *scratch* vuoto e senza il messaggio di benvenuto
(setq initial-scratch-message nil)

;;; ============================================================
;;; THEME
;;; ============================================================

(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(load-theme 'modus-vivendi t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:background unspecified :extend nil))))
 '(fringe ((t (:background unspecified))))
 '(mode-line ((t (:background "#160a26" :foreground "#c9b8e0"))))
 '(mode-line-inactive ((t (:background "#0d0615" :foreground "#5a4d6b")))))

;;; ============================================================
;;; EDITING
;;; ============================================================

;; Larghezza consigliata del testo
(setq-default fill-column 80)

;; Scrolling
(setq scroll-step 1)
(setq scroll-conservatively 10)

;; Mouse scrolling
(setq mouse-wheel-progressive-speed nil)


;;; ============================================================
;;; HISTORY
;;; ============================================================

;; Ricorda i file aperti recentemente
(recentf-mode 1)
(setq recentf-max-saved-items 100)

;; Ricorda la cronologia del minibuffer
(savehist-mode 1)

;; Font
(when (display-graphic-p)
  (set-face-attribute 'default nil
                      :font "Liberation Mono" ;; Previous font: Liberation Mono
                      :height 125
                      :weight 'regular))

;;; ============================================================
;;; VTERM
;;; ============================================================

(defun my-vterm (&optional arg)
  "Apre una NUOVA istanza di vterm.
Senza prefisso parte da ~/.
Con C-u parte dalla directory del buffer corrente."
  (interactive "P")
  (let ((default-directory
          (if arg
              default-directory
            (expand-file-name "~/"))))
    (vterm t)))

(global-set-key (kbd "C-c t") #'my-vterm)


;;; ============================================================
;;; VTERM PACKAGE + APERTURA AUTOMATICA ALL'AVVIO
;;; ============================================================

(use-package vterm
  :ensure t)

(setq initial-buffer-choice
      (lambda ()
        (vterm)
        (current-buffer)))

;;; ============================================================
;;; VTERM DIRECTORY
;;; ============================================================
(defun my-vterm-directory-sync (&optional buffer)
  "Sincronizza `default-directory' del buffer vterm leggendo /proc.
Funziona solo su Linux. BUFFER default al buffer corrente."
  (with-current-buffer (or buffer (current-buffer))
    (when (and (derived-mode-p 'vterm-mode)
               (bound-and-true-p vterm--process)
               (process-live-p vterm--process))
      (let* ((pid (process-id vterm--process))
             (dir (ignore-errors
                    (file-truename (format "/proc/%d/cwd/" pid)))))
        (when (and dir (file-directory-p dir))
          (setq-local default-directory (file-name-as-directory dir)))))))

(defun my-get-last-vterm-directory ()
  "Restituisce la directory del vterm più rilevante.
Priorità:
1. vterm attualmente visibile in una finestra
2. vterm più recente nella buffer-list
3. fallback a default-directory corrente"
  (let* ((visible-vterm
          (cl-find-if (lambda (buf)
                        (and (get-buffer-window buf 'visible)
                             (with-current-buffer buf
                               (derived-mode-p 'vterm-mode))))
                      (buffer-list)))
         (recent-vterm
          (cl-find-if (lambda (buf)
                        (with-current-buffer buf
                          (derived-mode-p 'vterm-mode)))
                      (buffer-list)))
         (target (or visible-vterm recent-vterm)))
    (if target
        (progn
          (my-vterm-directory-sync target)   ; forza sync
          (buffer-local-value 'default-directory target))
      default-directory)))

(defun my-find-file ()
  "Apre counsel-find-file partendo dalla directory dell'ultimo/visibile vterm."
  (interactive)
  (let ((dir (my-get-last-vterm-directory)))
    (if (fboundp 'counsel-find-file)
        (counsel-find-file nil dir)
      (let ((default-directory dir))
        (call-interactively #'find-file)))))

(global-set-key (kbd "C-x C-f") #'my-find-file)

;;; ============================================================
;;; IVY, COUNSEL & POSFRAME (POPUP CENTRALE GLOBALE)
;;; ============================================================

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-height 12)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil))

(use-package counsel
  :ensure t
  :after ivy
  :config
  (counsel-mode 1))

(use-package ivy-posframe
  :ensure t
  :after ivy
  :init
  (require 'eieio)
  :config
  (setq ivy-posframe-display-functions-alist
        '((t . ivy-posframe-display-at-frame-center)))

  (setq ivy-posframe-height 12)
  (setq ivy-posframe-width 110)
  (setq ivy-posframe-min-height 12)
  (setq ivy-posframe-min-width 110)

  (setq ivy-posframe-parameters
        '((internal-border-width . 2)
          (left-fringe . 10)
          (right-fringe . 10)
          (fit-frame-to-buffer . nil)))

  (setq ivy-posframe-font (face-font 'default))
  (setq posframe-text-scale-factor-function (lambda (_) 0))

  ;; Colori e bordi
  (set-face-attribute 'ivy-posframe nil
                      :background (face-background 'default nil t)
                      :foreground (face-foreground 'default nil t))

  (set-face-attribute 'ivy-posframe-border nil
                      :background "#b2b2b2")

  (ivy-posframe-mode 1))


;;; ============================================================
;;; MODELINE
;;; ============================================================

;; Icone necessarie per doom-modeline
(use-package all-the-icons
  :ensure t)
;; NB: la prima volta esegui M-x all-the-icons-install-fonts
;; per scaricare i font delle icone sul sistema

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 25)
  (setq doom-modeline-icon t)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-buffer-file-name-style 'auto)
  (setq doom-modeline-buffer-state-icon t)   ;; mostra il lucchetto/stato buffer
  (setq doom-modeline-minor-modes nil)
  (setq doom-modeline-enable-word-count nil))



;;; ============================================================
;;; KEYBINDINGS IVY/COUNSEL
;;; ============================================================

(global-set-key (kbd "C-x b")   #'counsel-switch-buffer)
(global-set-key (kbd "C-c b")   #'counsel-switch-buffer)
(global-set-key (kbd "M-x")     #'counsel-M-x)
(global-set-key (kbd "C-x C-r") #'counsel-recentf)
(global-set-key (kbd "C-+") #'text-scale-increase)
(global-set-key (kbd "C--") #'text-scale-decrease)

;;; ============================================================
;;; KEYBINDINGS
;;; ============================================================

;; Apri vterm
(global-set-key (kbd "C-c t") #'my-vterm)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
