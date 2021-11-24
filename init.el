(require 'package)

;; Disable automatic package startup
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("elpa" . "http://elpa.gnu.org/packages/"))

;; Initialize packages
(package-initialize)

;; Instale use-package
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(use-package evil
	:ensure t
	:init
	(setq evil-want-integration t)
	(setq evil-want-C-u-scroll t)

	(setq evil-cross-lines t)

	:config
	(evil-mode 1)

	(evil-global-set-key 'motion "j" 'evil-next-visual-line)
	(evil-global-set-key 'motion "k" 'evil-previous-visual-line))

;;(use-package auto-complete
;;	:ensure t
;;	:init
;;	(progn
;;		(ac-config-default)
;;		(global-auto-complete-mode t)))

(use-package company
	:after lsp-mode
	:hook (lsp-mode . company-mode)
	:bind (:map company-active-map
				 ("<tab>" . company-complete-selection))
				(:map lsp-mode-map
				 ("<tab>" . company-indent-or-complete-common))
	:custom
	(company-minimum-prefix-length 1)
	(company-idle-delay 0.0))

(use-package company-box
	:hook (company-mode . company-box-mode))

(use-package ivy
	:diminish
	:bind (("C-s" . swiper)
				 :map ivy-minibuffer-map
				 ("TAB" . ivy-alt-done)
				 ("C-l" . ivy-alt-done)
				 ("C-j" . ivy-next-line)
				 ("C-k" . ivy-previous-line)
				 :map ivy-switch-buffer-map
				 ("C-k" . ivy-previous-line)
				 ("C-l" . ivy-done)
				 ("C-d" . ivy-switch-buffer-kill)
				 :map ivy-reverse-i-search-map
				 ("C-k" . ivy-previous-line)
				 ("C-d" . ivy-reverse-i-search-kill))
	:config
	(ivy-mode 1))

(use-package counsel
	:ensure t
	:bind (("C-M-j" . 'counsel-switch-buffer)
				 :map minibuffer-local-map
				 ("C-r" . 'counsel-minibuffer-history))
	:custom
	(counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
	:config
	(counsel-mode 1))

(use-package counsel-projectile
	:after projectile
	:config
	(counsel-projectile-mode 1))

(use-package projectile
	:diminish projectile-mode
	:config (projectile-mode)
	:bind-keymap
	("C-c p" . projectile-command-map)
	:init
	(when (file-directory-p "~/workspace")
		(setq projectile-project-search-path '("~/workspace")))
	(setq projectile-switch-project-action #'projectile-dired))

(use-package editorconfig
	:ensure t
	:config
	(editorconfig-mode 1))

;; Atalhos
;(global-set-key (kbd "M-<tab>") 'other-window)
;(global-set-key (kbd "M-j") 'enlarge-window)
;(global-set-key (kbd "M-k") 'shrink-window)
;(global-set-key (kbd "M-l") 'enlarge-window-horizontally)
;(global-set-key (kbd "M-h") 'shrink-window-horizontally)

;(global-set-key (kbd "C-f") 'swiper-isearch)
(define-key evil-motion-state-map " " nil)

(define-key evil-normal-state-map (kbd "C-f") 'swiper-isearch)
(define-key evil-normal-state-map (kbd "C-r") 'swiper-isearch)
(define-key evil-normal-state-map (kbd "C-b") 'treemacs)
(define-key evil-normal-state-map (kbd "C-j") 'scroll-down)
(define-key evil-normal-state-map (kbd "C-k") 'scroll-up)

(define-key evil-normal-state-map (kbd "SPC SPC") 'find-file)

(define-key evil-normal-state-map (kbd "M-l") 'centaur-tabs-forward)
(define-key evil-normal-state-map (kbd "M-h") 'centaur-tabs-backward)
;; (define-key evil-visual-state-map (kbd "<tab>") 'indent-rigidly)

(global-set-key (kbd "<escape>")      'keyboard-escape-quit)

;(global-set-key (kbd "C-h") 'evil-window-split)
;(global-set-key (kbd "C-v") 'evil-window-vsplit)

(global-set-key [C-tab] 'counsel-switch-buffer)

(setq ns-alternate-modifier 'meta)
(setq ns-right-alternate-modifier 'none)

;; Delete selected text on insert
(delete-selection-mode 1)

(setq-default tab-width 2)
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
(setq indent-tabs-mode t)

;; Remove Welcome message
(setq inhibit-startup-message t)
;; Hilight on current line
(global-hl-line-mode t)
;; Remove blinking cursor
(blink-cursor-mode 0)
;; Remover tool bar
(tool-bar-mode -1)
;; Remove menu bar
(menu-bar-mode -1)
;; Remover barra de rolagem
(scroll-bar-mode -1)
;; Show line number globally
(global-linum-mode t)

(setq visible-bell nil)

;; Add doom modeline to the bottom
(use-package doom-modeline
	:ensure t
	:init (doom-modeline-mode 1)
	:custom ((doom-modeline-height 15)))

;; Setup doom-themes
(use-package doom-themes
	:ensure t
	:config
	(setq doom-themes-enable-bold t
				doom-themes-enable-italic t)

	(load-theme 'doom-one t)

	(doom-themes-visual-bell-config)
	(doom-themes-neotree-config)
	(setq doom-themes-treemacs-theme "doom-atom")
	(doom-themes-treemacs-config)
	(doom-themes-org-config))

(use-package all-the-icons
	:if (display-graphic-p)
	:commands all-the-icons-install-fonts
	:init
	(unless (find-font (font-spec :name "all-the-icons"))
		(all-the-icons-install-fonts t)))

(use-package all-the-icons-dired
	:if (display-graphic-p)
	:hook (dired-mode . all-the-icons-dired-mode))

(set-face-attribute 'default nil :font "Fira Code" :height 150)
;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code" :height 150)
;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 295 :weight 'regular)

(use-package dashboard
	:ensure t
	:config
	(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
	(setq dashboard-startup-banner "~/.emacs.d/dashboard-logos/rat.txt")
	(setq dashboard-center-content t)
	(setq dashboard-show-shortcuts nil)
	(setq dashboard-items '((recents  . 5)
													(bookmarks . 5)
													(projects . 5)
													(agenda . 5)
													(registers . 5)))	
	(dashboard-setup-startup-hook))

(use-package centaur-tabs
	:demand
	:config

	(centaur-tabs-mode t)
	:bind
	("C-p" . centaur-tabs-backward)
	("C-n" . centaur-tabs-forward))
(setq centaur-tabs-style "rounded")
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-set-modified-marker t)
(setq centaur-tabs-modified-marker "*")

(use-package treemacs
	:ensure t
	:defer t
	:init
	(with-eval-after-load 'winum
		(define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
	:config
	(progn
		(setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
					treemacs-deferred-git-apply-delay        0.5
					treemacs-directory-name-transformer      #'identity
					treemacs-display-in-side-window          t
					treemacs-eldoc-display                   t
					treemacs-file-event-delay                5000
					treemacs-file-extension-regex            treemacs-last-period-regex-value
					treemacs-file-follow-delay               0.2
					treemacs-file-name-transformer           #'identity
					treemacs-follow-after-init               t
					treemacs-expand-after-init               t
					treemacs-git-command-pipe                ""
					treemacs-goto-tag-strategy               'refetch-index
					treemacs-indentation                     2
					treemacs-indentation-string              " "
					treemacs-is-never-other-window           nil
					treemacs-max-git-entries                 5000
					treemacs-missing-project-action          'ask
					treemacs-move-forward-on-expand          nil
					treemacs-no-png-images                   nil
					treemacs-no-delete-other-windows         t
					treemacs-project-follow-cleanup          nil
					treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
					treemacs-position                        'left
					treemacs-read-string-input               'from-child-frame
					treemacs-recenter-distance               0.1
					treemacs-recenter-after-file-follow      nil
					treemacs-recenter-after-tag-follow       nil
					treemacs-recenter-after-project-jump     'always
					treemacs-recenter-after-project-expand   'on-distance
					treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
					treemacs-show-cursor                     nil
					treemacs-show-hidden-files               t
					treemacs-silent-filewatch                nil
					treemacs-silent-refresh                  nil
					treemacs-sorting                         'alphabetic-asc
					treemacs-select-when-already-in-treemacs 'move-back
					treemacs-space-between-root-nodes        t
					treemacs-tag-follow-cleanup              t
					treemacs-tag-follow-delay                1.5
					treemacs-text-scale                      nil
					treemacs-user-mode-line-format           nil
					treemacs-user-header-line-format         nil
					treemacs-wide-toggle-width               70
					treemacs-width                           25
					treemacs-width-increment                 1
					treemacs-width-is-initially-locked       t
					treemacs-workspace-switch-cleanup        nil)

		;; The default width and height of the icons is 22 pixels. If you are
		;; using a Hi-DPI display, uncomment this to double the icon size.
		;;(treemacs-resize-icons 44)

		(treemacs-follow-mode t)
		(treemacs-filewatch-mode t)
		(treemacs-fringe-indicator-mode 'always)

		(pcase (cons (not (null (executable-find "git")))
								 (not (null treemacs-python-executable)))
			(`(t . t)
			 (treemacs-git-mode 'deferred))
			(`(t . _)
			 (treemacs-git-mode 'simple)))

		(treemacs-hide-gitignored-files-mode nil))
	:bind
	(:map global-map
				("M-0"       . treemacs-select-window)
				("C-x t 1"   . treemacs-delete-other-windows)
				("C-x t t"   . treemacs)
				("C-x t B"   . treemacs-bookmark)
				("C-x t C-t" . treemacs-find-file)
				("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
	:after (treemacs evil)
	:ensure t)

(use-package treemacs-projectile
	:after (treemacs projectile)
	:ensure t)

(use-package treemacs-icons-dired
	:hook (dired-mode . treemacs-icons-dired-enable-once)
	:ensure t)

(defun efs/org-mode-setup ()
	;(org-indent-mode)
	(variable-pitch-mode 1)
	(visual-line-mode 1))

(defun efs/org-font-setup ()
	;; Replace list hyphen with dot
	(font-lock-add-keywords 'org-mode
													'(("^ *\\([-]\\) "
														 (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

	;; Set faces for heading levels
	(dolist (face '((org-level-1 . 1.2)
									(org-level-2 . 1.1)
									(org-level-3 . 1.05)
									(org-level-4 . 1.0)
									(org-level-5 . 1.1)
									(org-level-6 . 1.1)
									(org-level-7 . 1.1)
									(org-level-8 . 1.1)))
		(set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

	;; Ensure that anything that should be fixed-pitch in Org files appears that way
	(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
	(set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
	(set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
	(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
	(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
	(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
	(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org
	:hook (org-mode . efs/org-mode-setup)
	:config
	;; (setq org-ellipsis " ▾")
	(setq org-agenda-start-with-log-mode t)
	(setq org-log-done 'time)
	(setq org-log-into-drawer t)

	(setq org-agenda-files
	'("~/workspace/OrgFilesorgfiles/tasks.org"))

	(setq org-todo-keywords
		'((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
			(sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

	(setq org-refile-targets
		'(("tasks.org" :maxlevel . 1)))

	;; Save Org buffers after refiling!
	(advice-add 'org-refile :after 'org-save-all-org-buffers)

	(setq org-tag-alist
		'((:startgroup)
			 ; Put mutually exclusive tags here
			 (:endgroup)
			 ("@errand" . ?E)
			 ("@home" . ?H)
			 ("@work" . ?W)
			 ("agenda" . ?a)
			 ("planning" . ?p)
			 ("publish" . ?P)
			 ("batch" . ?b)
			 ("note" . ?n)
			 ("idea" . ?i)))

	;; Configure custom agenda views
	(setq org-agenda-custom-commands
	 '(("d" "Dashboard"
		 ((agenda "" ((org-deadline-warning-days 7)))
			(todo "NEXT"
				((org-agenda-overriding-header "Next Tasks")))
			(tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

		("n" "Next Tasks"
		 ((todo "NEXT"
				((org-agenda-overriding-header "Next Tasks")))))

		("W" "Work Tasks" tags-todo "+work-email")

		;; Low-effort next actions
		("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
		 ((org-agenda-overriding-header "Low Effort Tasks")
			(org-agenda-max-todos 20)
			(org-agenda-files org-agenda-files)))

		("w" "Workflow Status"
		 ((todo "WAIT"
						((org-agenda-overriding-header "Waiting on External")
						 (org-agenda-files org-agenda-files)))
			(todo "REVIEW"
						((org-agenda-overriding-header "In Review")
						 (org-agenda-files org-agenda-files)))
			(todo "PLAN"
						((org-agenda-overriding-header "In Planning")
						 (org-agenda-todo-list-sublevels nil)
						 (org-agenda-files org-agenda-files)))
			(todo "BACKLOG"
						((org-agenda-overriding-header "Project Backlog")
						 (org-agenda-todo-list-sublevels nil)
						 (org-agenda-files org-agenda-files)))
			(todo "READY"
						((org-agenda-overriding-header "Ready for Work")
						 (org-agenda-files org-agenda-files)))
			(todo "ACTIVE"
						((org-agenda-overriding-header "Active Projects")
						 (org-agenda-files org-agenda-files)))
			(todo "COMPLETED"
						((org-agenda-overriding-header "Completed Projects")
						 (org-agenda-files org-agenda-files)))
			(todo "CANC"
						((org-agenda-overriding-header "Cancelled Projects")
						 (org-agenda-files org-agenda-files)))))))

	(efs/org-font-setup))

(use-package org-bullets
	:after org
	:hook (org-mode . org-bullets-mode)
	:custom
	(org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
	(setq visual-fill-column-width 100
				visual-fill-column-center-text t)
	(visual-fill-column-mode 1))

(use-package visual-fill-column
	:hook (org-mode . efs/org-mode-visual-fill))

(org-babel-do-load-languages
	'org-babel-load-languages
	'((emacs-lisp . t)
		(python . t)))

;; Automatically tangle our emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
	(when (string-equal (buffer-file-name)
											(expand-file-name "~/.emacs.d/emacs.org"))
		;; Dynamic scoping to the rescue
		(let ((org-confirm-babel-evaluate nil))
			(org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(use-package lsp-mode
	:ensure t
	:commands lsp lsp-deferred)

(use-package lsp-ui
	:ensure t
	:hook (lsp-mode . lsp-ui-mode)
	:custom
	(lsp-ui-doc-position 'bottom))

(use-package lsp-ivy
	:ensure t)

;	(use-package flycheck
;		:ensure t
;		:init
;		(global-flycheck-mode)
;		(setq flycheck-clang-language-standard "c++11"))

;;	(defun setup-cpp-lang ()
		;; (setq lsp-clangd-binary-path "/usr/local/Cellar/llvm/13.0.0_1/bin/clangd")
		;; (setq flycheck-clang-language-standard "c++11")
		;; (setq lsp-clangd-executable "clangd-12")
		;; (setq lsp-clients-clangd-executable "clangd-12") 
;;		(lsp))

(add-hook 'c++-mode-hook 'lsp-deferred)
(add-hook 'c-mode-hook 'lsp-deferred)
(add-hook 'cuda-mode-hook 'lsp-deferred)
(add-hook 'objc-mode-hook 'lsp-deferred)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
	 '(all-the-icons-dired org-bullets use-package treemacs-projectile treemacs-icons-dired treemacs-evil lsp-ui lsp-ivy flycheck editorconfig doom-themes doom-modeline dashboard counsel-projectile company-native-complete company-box centaur-tabs bug-hunter)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )