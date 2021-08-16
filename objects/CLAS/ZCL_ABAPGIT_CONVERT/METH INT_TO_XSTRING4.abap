  METHOD int_to_xstring4.
* returns xstring of length 4 containing the integer value iv_i

    DATA: lv_x TYPE x LENGTH 4.


    lv_x = iv_i.
    rv_xstring = lv_x.

  ENDMETHOD.