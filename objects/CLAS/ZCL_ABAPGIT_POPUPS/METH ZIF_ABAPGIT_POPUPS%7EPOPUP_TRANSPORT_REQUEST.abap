  METHOD zif_abapgit_popups~popup_transport_request.

    DATA: lt_e071  TYPE STANDARD TABLE OF e071,
          lt_e071k TYPE STANDARD TABLE OF e071k.

    CALL FUNCTION 'TRINT_ORDER_CHOICE'
      EXPORTING
        wi_order_type          = is_transport_type-request
        wi_task_type           = is_transport_type-task
      IMPORTING
        we_order               = rv_transport
      TABLES
        wt_e071                = lt_e071
        wt_e071k               = lt_e071k
      EXCEPTIONS
        no_correction_selected = 1
        display_mode           = 2
        object_append_error    = 3
        recursive_call         = 4
        wrong_order_type       = 5
        OTHERS                 = 6.

    IF sy-subrc = 1.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ELSEIF sy-subrc > 1.
      zcx_abapgit_exception=>raise( |Error from TRINT_ORDER_CHOICE { sy-subrc }| ).
    ENDIF.

  ENDMETHOD.