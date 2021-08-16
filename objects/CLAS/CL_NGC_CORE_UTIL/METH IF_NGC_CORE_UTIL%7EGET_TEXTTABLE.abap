  METHOD if_ngc_core_util~get_texttable.

    CLEAR: ev_texttable, ev_checkfield.


    CALL FUNCTION 'DDUT_TEXTTABLE_GET'
      EXPORTING
        tabname    = iv_table_name
      IMPORTING
        texttable  = ev_texttable
        checkfield = ev_checkfield.

  ENDMETHOD.