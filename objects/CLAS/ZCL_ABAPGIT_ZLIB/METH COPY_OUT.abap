  METHOD copy_out.

* copy one byte at a time, it is not possible to copy using
* string offsets, as it might copy data that does not exist
* in mv_out yet

    DATA: lv_distance TYPE i,
          lv_index    TYPE i,
          lv_x        TYPE x LENGTH 1.


    lv_distance = xstrlen( gv_out ) - is_pair-distance.
    DO is_pair-length TIMES.
      lv_index = sy-index - 1 + lv_distance.
      lv_x = gv_out+lv_index(1).
      CONCATENATE gv_out lv_x INTO gv_out IN BYTE MODE.
    ENDDO.

  ENDMETHOD.