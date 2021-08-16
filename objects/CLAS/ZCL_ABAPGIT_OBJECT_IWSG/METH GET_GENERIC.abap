  METHOD get_generic.

    CREATE OBJECT ro_generic
      EXPORTING
        is_item = ms_item.

  ENDMETHOD.