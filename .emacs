(require 'package)
(add-to-list 'package-archives
	'("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
   '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

(add-to-list 'load-path "~/.emacs.d/")

(setq inferior-lisp-program "sbcl")
(add-to-list 'load-path "/home/leiting/.emacs.d/slime-2.5/")
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

;; w3m-load
(add-to-list 'load-path "~/.emacs.d/emacs-w3m")
(require 'w3m-load)

;; set chm-view
(require 'chm-view)
(setq browse-url-browser-function 'w3m-browse-url)

;; eim
(add-to-list 'load-path "/home/leiting/local/share/emacs/site-lisp/eim")
(autoload 'eim-use-package "eim" "Another emacs input method")
;; Tooltip 暂时还不好用
(setq eim-use-tooltip nil)

(register-input-method
 "eim-wb" "euc-cn" 'eim-use-package
 "五笔" "汉字五笔输入法" "wb.txt")
(register-input-method
 "eim-py" "euc-cn" 'eim-use-package
 "拼音" "汉字拼音输入法" "py.txt")

;; 用 ; 暂时输入英文
(require 'eim-extra)
(global-set-key ";" 'eim-insert-ascii)

;; youdao dict
(defun yodao-dict-search-wordap (&optional word)
"Use python script dict to look up word under point"
(interactive)
(or word (setq word (current-word)))
(shell-command (format "python ~/.emacs.d/youdao_dict.py %s" word)))
(global-set-key [f7] 'yodao-dict-search-wordap)

;; get rid of menu bar in terminal emacs
(if (equal window-system nil)
    (menu-bar-mode nil))


;; bind sexp key
(global-set-key [(meta left)] 'backward-sexp)
(global-set-key [(meta right)] 'forward-sexp)

;; jdee
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp/")
;;(load "jde")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(ido-enable-flex-matching t)
 '(jde-jdk-registry (quote (("1.7" . "/usr/lib/jvm/jdk1.7.0_45") ("1.6" . "/usr/lib/jvm/java-6-oracle")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq x-select-enbale-clipboard t)

;; coffeescript
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

 ;; automatically clean up bad whitespace
(setq whitespace-action '(auto-cleanup))
 ;; only show bad whitespace
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab))
 ;; This gives you a tab of 2 spaces
(custom-set-variables '(coffee-tab-width 2))

;; Move to corresponding point in JavaScript file after compiling
(setq coffee-args-compile '("-c" "-m")) ;; generating sourcemap
(add-hook 'coffee-after-compile-hook 'sourcemap-goto-corresponding-point)

;; If you want to remove sourcemap file after jumping corresponding point
(defun my/coffee-after-compile-hook (props)
  (sourcemap-goto-corresponding-point props)
  (delete-file (plist-get props :sourcemap)))
(add-hook 'coffee-after-compile-hook 'my/coffee-after-compile-hook)


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
     (color-theme-classic)))

;; textmate
(require 'textmate)
(textmate-mode)

;; nxml-mode
(add-to-list 'load-path "/home/leiting/.emacs.d/nxml-mode-20041004/")
(add-to-list 'auto-mode-alist '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode))

;; tidy 
(add-to-list 'load-path "~/.emacs.d/elpa/tidy-20111222.1756/")
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
