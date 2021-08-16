  METHOD zif_abapgit_object~delete.

    DATA:
      lx_error              TYPE REF TO cx_root,
      li_wb_object_operator TYPE REF TO object,
      lv_transport_request  TYPE trkorr.

    lv_transport_request = get_transport_req_if_needed( iv_package ).

    li_wb_object_operator = get_wb_object_operator( ).

    TRY.
        CALL METHOD li_wb_object_operator->('IF_WB_OBJECT_OPERATOR~DELETE')
          EXPORTING
            transport_request = lv_transport_request.

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.