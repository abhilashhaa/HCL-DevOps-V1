  METHOD zif_abapgit_object~deserialize.

    DATA:
      li_object_data_model TYPE REF TO if_wb_object_data_model,
      lx_error             TYPE REF TO cx_swb_exception.

    FIELD-SYMBOLS:
      <ls_service_definition> TYPE any,
      <lv_source>             TYPE data.

    ASSIGN mr_service_definition->* TO <ls_service_definition>.
    ASSERT sy-subrc = 0.

    io_xml->read(
      EXPORTING
        iv_name = 'SRVD'
      CHANGING
        cg_data = <ls_service_definition> ).

    ASSIGN COMPONENT 'CONTENT-SOURCE' OF STRUCTURE <ls_service_definition>
           TO <lv_source>.
    ASSERT sy-subrc = 0.

    <lv_source> = mo_files->read_string( 'assrvd' ).

    TRY.
        CREATE OBJECT li_object_data_model TYPE ('CL_SRVD_WB_OBJECT_DATA').
        li_object_data_model->set_data( <ls_service_definition> ).
        mi_persistence->save( li_object_data_model ).

        tadir_insert( iv_package ).
        corr_insert( iv_package ).

      CATCH cx_swb_exception INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.