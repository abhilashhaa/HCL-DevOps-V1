  METHOD zif_abapgit_object~serialize.

    DATA:
      li_object_data_model TYPE REF TO if_wb_object_data_model,
      lx_error             TYPE REF TO cx_swb_exception.

    FIELD-SYMBOLS:
      <ls_service_binding> TYPE any.

    ASSIGN mr_service_binding->* TO <ls_service_binding>.
    ASSERT sy-subrc = 0.

    TRY.
        mi_persistence->get(
          EXPORTING
            p_object_key  = mv_service_binding_key
            p_version     = 'A'
          CHANGING
            p_object_data = li_object_data_model ).

        li_object_data_model->get_data( IMPORTING p_data = <ls_service_binding> ).

        clear_fields( CHANGING cs_service_binding = <ls_service_binding> ).

      CATCH cx_swb_exception INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

    io_xml->add(
        iv_name = 'SRVB'
        ig_data = <ls_service_binding> ).

  ENDMETHOD.