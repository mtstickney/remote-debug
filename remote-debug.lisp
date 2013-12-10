;;;; remote-debug.lisp

(in-package #:remote-debug)

(defvar *swank-port* swank::default-server-port)

(defun debug-handler (&key (port *swank-port*) (parent-hook *debugger-hook*))
  "Return a function to be used as *DEBUGGER-HOOK* that serves the debugger over Swank."
  (lambda (condition hook)
    (declare (ignore hook))
    (let ((*current-condition* condition)
          (*parent-hook* parent-hook))
      (declare (special *current-condition* *parent-hook*))
      ;; Run the server until the condition is actually handled
      (loop
         (swank:create-server :port port :style nil :dont-close nil :backlog 0)))))

(defun call-with-remote-debug (func &rest args)
  (let ((*debugger-hook* (debug-handler)))
    (apply func args)))

(defmacro with-remote-debug ((&optional (port *swank-port*)) &body body)
  (let ((port-var (gensym "PORT")))
    `(let* ((,port-var ,port)
            (*swank-port* ,port-var))
       (call-with-remote-debug (lambda () ,@body)))))

(defun invoke-debug ()
  (declare (special *parent-hook* *current-condition*))
  (when (and (boundp '*parent-hook*)
             *parent-hook*)
    (funcall *parent-hook* *current-condition* *parent-hook*))
  (invoke-debugger *current-condition*))
