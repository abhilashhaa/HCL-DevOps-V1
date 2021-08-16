  METHOD read.

    DATA: ls_name TYPE iacikeyt.


    ls_name = ms_item-obj_name.

    w3_api_load( EXPORTING is_name = ls_name
                 IMPORTING es_attr = rs_attr ).

    CLEAR: rs_attr-chname,
           rs_attr-tdate,
           rs_attr-ttime,
           rs_attr-devclass.

  ENDMETHOD.