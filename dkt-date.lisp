;;;; dkt-date.lisp

(in-package #:dkt-date)

(defparameter *week-days* '("Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday"))


(defun two-digit-str (int)
  "Convert an integer in the range 0 to 99 into a two-character string
with leading 0, if necessary."
  (format nil "~2,1,0,'0@A" int))


(defun four-digit-str (int)
  "Convert an integer in the range 0 to 9999 into a four-character
string with leading zeroes, if necessary."
  (format nil "~4,1,0,'0@A" int))


(defun human-date (date-string)
  "Strip the T from ISO8601 dates, and remove decimal portion of seconds, if any."
  (let* ((date-no-t (substitute #\Space #\T date-string))
         (dec-point-pos (search "." date-no-t :from-end t)))
    (if (null dec-point-pos)
        date-no-t
        (subseq date-no-t 0 dec-point-pos))))


(defun iso-8601-date-now (&key (hyphen t))
  "Return a string representing the current date in ISO 8601 format."
  (let ((two-digits "~2,1,0,'0@A"))
    (multiple-value-bind (s m h dt mth yr day)
        (get-decoded-time)
      (declare (ignorable day h m s))
      (format nil (concatenate 'string
                               "~A" (if hyphen "-" "") two-digits (if hyphen "-" "") two-digits)
              yr mth dt))))


(defun iso-8601-time-now (&key (colon t))
  "Return a string representing the current time in ISO 8601 HH:mm:ss format."
  (let ((two-digits "~2,1,0,'0@A"))
    (multiple-value-bind (s m h dt mth yr day)
        (get-decoded-time)
      (declare (ignorable day yr mth dt))
      (format nil (concatenate 'string
                               two-digits (if colon ":" "") two-digits (if colon ":" "") two-digits)
              h m s))))


(defun iso-8601-date-time-now (&key (t-sep nil) (hyphen t) (colon t))
  "Return a string representing the current date and time in ISO 8601 format."
  (concatenate 'string
               (iso-8601-date-now :hyphen hyphen)
               (if t-sep "T" " ")
               (iso-8601-time-now :colon colon)))


(defun make-iso-8601-date (year month day &key (hyphen t))
  "Given numerical values for the year, month and day, return a
string representing the date in ISO 8601 format."
  (let ((two-digits "~2,1,0,'0@A")
        (four-digits "~4,1,0,'0@A"))
    (format nil (concatenate 'string
                             four-digits (if hyphen "-" "") two-digits (if hyphen "-" "") two-digits)
            year month day)))


(defun date-portion (iso-8601-date-time)
  "Return the date portion of an ISO 8601 date/time string.
Assumes that the date string contains hyphen separators, and is
therefore exactly ten characters long."
  (subseq iso-8601-date-time 0 10))


(defun last-month ()
  "Return ISO 8601 year/month string for the month previous to the current month.
Example: if current month is May 2020, return \"2020-04\"."
  (let* ((today-str (iso-8601-date-now))
         (old-year-integer (extract-year today-str))
         (old-month-integer (extract-month today-str))
         (new-year-integer (if (> old-month-integer 1)
                               old-year-integer
                               (1- old-year-integer)))
         (new-month-integer (if (> old-month-integer 1)
                                (1- old-month-integer)
                                12)))
    (concatenate 'string
                 (four-digit-str new-year-integer)
                 "-"
                 (two-digit-str new-month-integer))))


(defun extract-year (iso-8601-date)
  "Return the integer year represented by the ISO-8601-DATE."
  (parse-integer (subseq iso-8601-date 0 4)))


(defun extract-month (iso-8601-date)
  "Return the integer month represented by the ISO-8601-DATE."
  (parse-integer (subseq iso-8601-date
                         (1+ (or (position #\- iso-8601-date :end 7) 3))
                         (or (position #\- iso-8601-date :start 5 :end 8) 6))))


(defun extract-day (iso-8601-date)
  "Return the integer day of the month represented by the ISO-8601-DATE."
  (let ((second-hyphen-pos (position #\- iso-8601-date :start 5 :end 8)))
    (parse-integer (subseq iso-8601-date
                           (if (null second-hyphen-pos) 6 (1+ second-hyphen-pos))
                           (if (null second-hyphen-pos) 8 (+ 3 second-hyphen-pos))))))


(defun date-diff (date-1 date-2)
  "Return the number of days between DATE-1 and DATE-2."
  (let ((local-time:*default-timezone* local-time:+utc-zone+))
    (truncate (local-time:timestamp-difference (local-time:parse-timestring date-2)
                                               (local-time:parse-timestring date-1))
              local-time:+seconds-per-day+)))


(defun num-day-of-week (date)
  "Return the numerical day of the week for DATE.
1 for Sunday, 2 or Monday, etc., up to 7 for Saturday."
  (let ((day-num (mod (+ 8 (local-time:timestamp-day-of-week (local-time:parse-timestring date))) 7)))
    (if (= day-num 0)
        7
        day-num)))


(defun day-of-week (date)
  "Return the English day of the week name for the given DATE."
  (nth (1- (num-day-of-week date)) *week-days*))

