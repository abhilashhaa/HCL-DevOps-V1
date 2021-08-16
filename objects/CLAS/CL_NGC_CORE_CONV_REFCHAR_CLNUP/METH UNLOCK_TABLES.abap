  METHOD unlock_tables.

    DATA:
      lv_varkey  TYPE rstable-varkey,
      lt_tabname TYPE STANDARD TABLE OF rstable-tabname.

    lv_varkey  = sy-mandt.
    lt_tabname = VALUE #( ( 'AUSP' ) ).

    LOOP AT lt_tabname REFERENCE INTO DATA(lr_tabname).
      CALL FUNCTION 'DEQUEUE_E_TABLE'
        EXPORTING
          tabname = lr_tabname->*
          varkey  = lv_varkey.
    ENDLOOP.

  ENDMETHOD.