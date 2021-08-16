  METHOD zif_abapgit_object~exists.

    DATA: lv_domname TYPE dd01l-domname.


    SELECT SINGLE domname FROM dd01l INTO lv_domname
      WHERE domname = ms_item-obj_name
      AND as4local = 'A'
      AND as4vers = '0000'.
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.