  METHOD zif_abapgit_object~serialize.

    DATA:
      li_object_data_model TYPE REF TO if_wb_object_data_model,
      lv_source            TYPE string,
      lx_error             TYPE REF TO cx_swb_exception.

    FIELD-SYMBOLS:
      <ls_service_definition> TYPE any,
      <lv_source>             TYPE data.

    ASSIGN mr_service_definition->* TO <ls_service_definition>.
    ASSERT sy-subrc = 0.

    TRY.
        mi_persistence->get(
          EXPORTING
            p_object_key  = mv_service_definition_key
            p_version     = 'A'
          CHANGING
            p_object_data = li_object_data_model ).

        li_object_data_model->get_data( IMPORTING p_data = <ls_service_definition> ).

        ASSIGN COMPONENT 'CONTENT-SOURCE' OF STRUCTURE <ls_service_definition>
               TO <lv_source>.
        ASSERT sy-subrc = 0.

        lv_source = <lv_source>.

        clear_fields( CHANGING cs_service_definition = <ls_service_definition> ).

      CATCH cx_swb_exception INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

    io_xml->add(
        iv_name = 'SRVD'
        ig_data = <ls_service_definition> ).

    mo_files->add_string(
        iv_ext    = 'assrvd'
        iv_string = lv_source ).

  ENDMETHOD.