(add-hook 'c-mode-common-hook
          (lambda ()
            (if (derived-mode-p 'c-mode 'c++-mode)
                (cppcm-reload-all)
              )))
;; OPTIONAL, somebody reported that they can use this package with Fortran
(add-hook 'c90-mode-hook (lambda () (cppcm-reload-all)))
;; OPTIONAL, avoid typing full path when starting gdb
(global-set-key (kbd "C-c C-g")
 '(lambda ()(interactive) (gud-gdb (concat "gdb --fullname " (cppcm-get-exe-path-current-buffer)))))
;; OPTIONAL, some users need specify extra flags forwarded to compiler
(setq cppcm-extra-preprocss-flags-from-user '("-I/usr/src/linux/include" "-DNDEBUG"))

;; Open shell
(global-set-key (kbd "C-1") 'shell)


;; Go-to-line
(global-set-key (kbd "M-g") 'goto-line)

;; Killing a line backwards can be done with ‘C-0 C-k’ or ‘C-u 0 C-k’.
(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(global-set-key "\C-q" 'backward-kill-line) ;; `C-q'


;; define keybind Ctrl-c p to swap buffers in the same window
(defun swap-buffers-in-windows ()
  "Put the buffer from the selected window in next window, and vice versa"
  (interactive)
  (let* ((this (selected-window))
         (other (next-window))
         (this-buffer (window-buffer this))
         (other-buffer (window-buffer other)))
    (set-window-buffer other this-buffer)
    (set-window-buffer this other-buffer)
    )
  )
(global-set-key (kbd "C-c p") 'swap-buffers-in-windows)

;; disable maximize frame 
;; in .emacs.d/lisp/init-misc.el
;; comment line (add-hook 'window-setup-hook 'maximize-frame t)
;; open eshell
(defun open-eshell-other-buffer ()
  "Open eshell in other buffer"
  (interactive)
  (split-window-vertically)
  (eshell))
(global-set-key [C-f1] 'open-eshell-other-buffer)
(global-set-key [C-f2] 'eshell)

(set-default-font "Monaco 14")
;; could not show first two rows on Mac OS
;; (require 'maxframe)
;; (add-hook 'window-setup-hook 'maximize-frame t)
(when window-system (set-frame-size (selected-frame) 200 120))
