(add-to-list 'load-path "~/.emacs.d/")

(setq inferior-lisp-program "sbcl")
(add-to-list 'load-path "/home/leiting/.emacs.d/slime-2.5/")
(require 'slime)
(slime-setup)
(require 'slime-autoloads)
(slime-setup '(slime-fancy));beautify the sbcl

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

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
(load "jde")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(jde-jdk-registry (quote (("1.7" . "/usr/lib/jvm/jdk1.7.0_45") ("1.6" . "/usr/lib/jvm/java-6-oracle")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq x-select-enbale-clipboard t)
