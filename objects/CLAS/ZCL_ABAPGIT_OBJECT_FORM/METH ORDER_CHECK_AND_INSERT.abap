  METHOD order_check_and_insert.

    DATA: lv_order TYPE e071k-trkorr.

    CALL FUNCTION 'SAPSCRIPT_ORDER_CHECK'
      EXPORTING
        objecttype           = ms_item-obj_type
        form                 = mv_form_name
      EXCEPTIONS
        invalid_input        = 1
        object_locked        = 2
        object_not_available = 3
        OTHERS               = 4.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    CALL FUNCTION 'SAPSCRIPT_ORDER_INSERT'
      EXPORTING
        objecttype     = ms_item-obj_type
        form           = mv_form_name
        masterlang     = mv_language
      CHANGING
        order          = lv_order
      EXCEPTIONS
        invalid_input  = 1
        order_canceled = 2
        OTHERS         = 3.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.