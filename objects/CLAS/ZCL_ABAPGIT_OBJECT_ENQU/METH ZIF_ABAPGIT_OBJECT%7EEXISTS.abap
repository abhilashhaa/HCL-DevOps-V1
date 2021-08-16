  METHOD zif_abapgit_object~exists.

    DATA: lv_viewname TYPE dd25l-viewname.


    SELECT SINGLE viewname FROM dd25l INTO lv_viewname
      WHERE viewname = ms_item-obj_name
      AND as4local = 'A'
      AND as4vers = '0000'.
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.