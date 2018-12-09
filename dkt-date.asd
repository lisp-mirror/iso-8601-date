;;;; dkt-date.asd

(asdf:defsystem #:dkt-date
  :description "Miscellaneous date routines based around ISO-8601 representation."
  :author "David K. Trudgett"
  :license  "LLGPL"
  :version "0.0.1"
  :serial t
  :depends-on (#:local-time)
  :components ((:file "package")
               (:file "dkt-date")))
