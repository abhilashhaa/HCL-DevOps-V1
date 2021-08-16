  METHOD unescape.
* do not use cl_http_utility as it does strange things with the encoding
    rv_string = iv_string.

* todo, more to be added here
    REPLACE ALL OCCURRENCES OF '%3F' IN rv_string WITH '?'.
    REPLACE ALL OCCURRENCES OF '%3D' IN rv_string WITH '='.

  ENDMETHOD.