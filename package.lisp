;;;; package.lisp

(defpackage #:remote-debug
  (:use #:cl)
  (:export #:*swank-port*
           #:*current-condition*
           #:call-with-remote-debug
           #:with-remote-debug
           #:invoke-debug))
