METHOD unlock_tables.

  DATA:
    lv_varkey  TYPE rstable-varkey,
    lt_tabname TYPE STANDARD TABLE OF rstable-tabname.

  lv_varkey  = sy-mandt.
  lt_tabname = VALUE #( ( 'AUSP' ) ( 'TCLAO' ) ( 'TCLT' ) ).

  LOOP AT lt_tabname ASSIGNING FIELD-SYMBOL(<ls_tabname>).
    CALL FUNCTION 'DEQUEUE_E_TABLE'
      EXPORTING
        tabname = <ls_tabname>
        varkey  = lv_varkey.
  ENDLOOP.

ENDMETHOD.