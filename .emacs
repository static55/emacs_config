(package-initialize)
1;4205;0c(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))
(add-to-list 'load-path "/opt/ros/kinetic/share/emacs/site-lisp")
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(require 'platformio-mode)
(require 'rosemacs-config)
(require 'rosemacs)
(invoke-rosemacs)
(global-set-key "\C-x\C-r" ros-keymap)

(setq compilation-scroll-output 'first-error)

(defun ros-catkin-make ()
  (interactive)
  (setq default-directory "~/catkin_ws")
  (compile "cd /home/user/catkin_ws && catkin_make && catkin_make install"))

(global-set-key (kbd "C-x C-r M") 'ros-catkin-make)

(defun ros-launch-motortest ()
  (interactive)
  (setq default-directory "~/catkin_ws")
  (compile "roslaunch motortest motortest.launch"))

(global-set-key (kbd "C-x C-r ,") 'ros-launch-motortest)

(add-hook 'c++-mode-hook
	  (lambda ()
	    (platformio-conditionally-enable)))

;(load-theme 'manoj-dark)
(set-face-foreground 'font-lock-comment-face "blue")
(set-face-foreground 'font-lock-string-face "blue")
(set-face-foreground 'font-lock-comment-delimiter-face "blue")
(set-face-foreground 'font-lock-keyword-face "magenta")
(set-face-foreground 'font-lock-function-name-face "magenta")
(set-face-background 'default "#111111")
(set-face-background 'region "#333355")
(set-face-background 'highlight "#333355")

;C-/ and C-*
(global-set-key (kbd "M-O 5 j") 'end-of-buffer)
(global-set-key (kbd "M-O 5 o") 'beginning-of-buffer)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 5)

(global-set-key (kbd "<backtab>") 'un-indent-by-removing-4-spaces)
(defun un-indent-by-removing-4-spaces ()
  "remove 4 spaces from beginning of of line"
  (interactive)
  (save-excursion
    (save-match-data
      (beginning-of-line)
      ;; get rid of tabs at beginning of line
      (when (looking-at "^\\s-+")
	(untabify (match-beginning 0) (match-end 0)))
      (when (looking-at "^    ")
	        (replace-match "")))))
