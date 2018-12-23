# EclecticSE ISO 8601 Date Representation Routines

### _David K. Trudgett_

Miscellaneous date routines based around the ISO 8601 string
representation.


## Function List

* __date-add__
  
  Add a given number of days to a date.
  
* __date-diff__
  
  Return the number of days between two dates.
  
* __date-portion__ 
  
  Return the date portion of an ISO 8601 date/time string. Assumes
  that the date string contains hyphen separators, and is therefore
  exactly ten characters long.

* __day-of-week__

  For a given date, return the day of the week on which it falls.

* __extract-day__

  For a given date, return the integer value of the day of the month.

* __extract-month__

  For a given date, return the integer value of the month of the year.

* __extract-year__

  For a given date, return the integer value of the year.
  
* __human-date__

  Strip the T from an ISO 8601 date, and remove decimal portion of
  the seconds value, if any.
  
* __iso-8601-date-now__

  Return today's date in ISO 8601 string format.

* __iso-8601-date-time-now__

  Return the current date and time as an ISO 8601 date and time
  string.
  
* __iso-8601-time-now__

  Return the current time in ISO 8601 string format.
  
* __last-month__

  Return the ISO 8601 year/month string for the month previous to the
  current month. Example: if current month is May 2020, return
  "2020-04".

* __make-iso-8601-date__

  Given numerical values for the year, month and day of the month,
  return the corresponding ISO 8601 date string.
  
* __num-day-of-week__
  
  For a given ISO 8601 date string, return the numerical day of the
  week on which it falls, where 1 = Sunday, and so on. Note: Monday is
  not _the_ first day of the week.

## License

LLGPL

