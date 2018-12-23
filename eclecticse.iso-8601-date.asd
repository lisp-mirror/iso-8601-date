;;;; eclecticse.iso-8601-date.asd

(asdf:defsystem #:eclecticse.iso-8601-date
  :description "Miscellaneous date routines based around ISO-8601 representation."
  :author "David K. Trudgett"
  :license  "LLGPL"
  :version "1.0.0"
  :serial t
  :depends-on (#:local-time)
  :components ((:file "package")
               (:file "iso-8601-date")))
