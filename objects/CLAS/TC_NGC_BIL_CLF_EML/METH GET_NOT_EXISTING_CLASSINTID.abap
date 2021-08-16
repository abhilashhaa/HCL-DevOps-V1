  METHOD get_not_existing_classintid.

    DATA(lv_classinternalid) = COND #( WHEN iv_classinternalid IS INITIAL THEN CONV clint( 1 ) ELSE iv_classinternalid ).

    SELECT SINGLE @abap_true FROM klah
      INTO @DATA(lv_exists)
      WHERE
        clint = @lv_classinternalid.

    IF lv_exists = abap_true.
      lv_classinternalid += 1.
      rv_classinternalid = me->get_not_existing_classintid( lv_classinternalid ).
    ELSE.
      rv_classinternalid = lv_classinternalid.
    ENDIF.

  ENDMETHOD.