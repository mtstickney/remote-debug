;;;; remote-debug.asd

(asdf:defsystem #:remote-debug
  :serial t
  :description "Describe remote-debug here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (#:swank)
  :components ((:file "package")
               (:file "remote-debug")))

