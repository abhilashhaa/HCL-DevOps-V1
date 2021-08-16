  METHOD zif_abapgit_object~serialize.

    DATA:
      li_object_data_model  TYPE REF TO if_wb_object_data_model,
      lx_error              TYPE REF TO cx_root,
      li_wb_object_operator TYPE REF TO object.

    FIELD-SYMBOLS:
      <ls_logical_db_schema> TYPE any.

    ASSIGN mr_logical_db_schema->* TO <ls_logical_db_schema>.
    ASSERT sy-subrc = 0.

    li_wb_object_operator = get_wb_object_operator( ).

    TRY.
        CALL METHOD li_wb_object_operator->('IF_WB_OBJECT_OPERATOR~READ')
          EXPORTING
            version        = 'A'
          IMPORTING
            data           = <ls_logical_db_schema>
            eo_object_data = li_object_data_model.

        clear_fields( CHANGING cs_logical_db_schema = <ls_logical_db_schema> ).

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

    io_xml->add(
        iv_name = 'AMSD'
        ig_data = <ls_logical_db_schema> ).

  ENDMETHOD.