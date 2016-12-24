
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'package)
(add-to-list 'package-archives
   '("melpa-stable" . "http://melpa-stable.melpa.org/packages/") t)
(setq package-check-signature nil)
(package-initialize)

;;install packages
;; load package list
(unless package-archive-contents
    (package-refresh-contents))
;; packages want to install
(setq package-list '(slime auto-complete nodejs-repl chm-view chinese-pyim chinese-pyim-wbdict
                           ido color-theme tidy emmet-mode web-mode))
;; install package
(dolist (package package-list)
    (unless (package-installed-p package)
                    (package-install package)))

;(add-to-list 'load-path "~/.emacs.d/")
;(let ((default-directory "~/.emacs.d/"))
;    (normal-top-level-add-subdirs-to-load-path))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(setq inferior-lisp-program "sbcl")
(require 'slime)
(slime-setup)
(require 'slime-autoloads)
(slime-setup '(slime-fancy));beautify the sbcl

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
(global-auto-complete-mode t)
(setq ac-modes '(c++-mode sql-mode java-mode JavaScript-mode css-mode html-mode coffee-mode js-mode text-mode jde-mode lisp-mode python-mode emacs-lisp-mode eshell-mode))

(require 'nodejs-repl)

;;; bind Ctrl-c d to kill-whole-line function
;(global-set-key "\C-cd" 'kill-whole-line)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(global-set-key (kbd "C-SPC") 'set-mark-command)

;; set chm-view
(require 'chm-view)
(setq browse-url-browser-function 'w3m-browse-url)

;; Chinese pyim
(require 'chinese-pyim)
(require 'chinese-pyim-wbdict)

;;(setq default-input-method "chinese-pyim")
(setq pyim-default-scheme 'wubi)
;;(setq pyim-use-tooltip 'popup)
(chinese-pyim-wbdict-gb2312-enable) ; gb2312 version
(global-set-key (kbd "C-\\") 'toggle-input-method)
(add-hook 'emacs-startup-hook
            #'(lambda () (pyim-restart-1 t)))

;; get rid of menu bar in terminal emacs
(if (equal window-system nil)
    (menu-bar-mode nil))


;; bind sexp key
(global-set-key [(meta left)] 'backward-sexp)
(global-set-key [(meta right)] 'forward-sexp)


(setq x-select-enbale-clipboard t)

 ;; automatically clean up bad whitespace
(setq whitespace-action '(auto-cleanup))
 ;; only show bad whitespace
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab))
 ;; This gives you a tab of 2 spaces
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(package-selected-packages
   (quote
    (web-mode w3m tidy textmate slime nodejs-repl idomenu emmet-mode color-theme chm-view chinese-wbim chinese-pyim-wbdict auto-complete))))

;; ido
(require 'ido)
(ido-mode t)

;; idomenu
(autoload 'idomenu "idomenu" nil t)

;; make emacs transparent
(defun transparency (value)
   "Sets the transparency of the frame window. 0=transparent/100=opaque"
   (interactive "nTransparency Value 0 - 100 opaque:")
   (set-frame-parameter (selected-frame) 'alpha value))
(transparency 95)

;; color theme
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-calm-forest)))

;; tidy 
(autoload 'tidy-buffer "tidy" "Run Tidy HTML parser on current buffer" t)
(autoload 'tidy-parse-config-file "tidy" "Parse the `tidy-config-file'" t)
(autoload 'tidy-save-settings "tidy" "Save settings to `tidy-config-file'" t)
(autoload 'tidy-build-menu "tidy" "Install an options menu for HTML Tidy." t)

(defun my-html-mode-hook () "Customize my html-mode"
  (tidy-build-menu html-mode-map)
  (local-set-key [(control c) (control c)] 'tidy-buffer)
  (setq sgml-validate-command "tidy"))
(add-hook 'html-mode-hook 'my-html-mode-hook)

;; shell autocomplete
;;(require 'readline-complete)
(setq explicit-shell-file-name "bash")
(setq explicit-bash-args '("-c" "export EMACS=; stty echo; bash"))
(setq comint-process-echoes t)
(add-to-list 'ac-modes 'shell-mode)
;;(add-hook 'shell-mode-hook 'ac-rlc-setup-sources)

;; emmet-mode
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'html-mode-hook 'emmet-mode) ;;
(add-hook 'web-mode-hook  'emmet-mode)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-code-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-markup-indent-offset 2)
