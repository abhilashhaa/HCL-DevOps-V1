  METHOD zif_abapgit_object~deserialize.

    DATA:
      li_object_data_model  TYPE REF TO if_wb_object_data_model,
      li_wb_object_operator TYPE REF TO object,
      lx_error              TYPE REF TO cx_root,
      lv_transport_request  TYPE trkorr.

    FIELD-SYMBOLS:
      <ls_dependency_rule> TYPE any,
      <lv_source>          TYPE data.

    ASSIGN mr_dependency_rule->* TO <ls_dependency_rule>.
    ASSERT sy-subrc = 0.

    io_xml->read(
      EXPORTING
        iv_name = 'DRUL'
      CHANGING
        cg_data = <ls_dependency_rule> ).

    li_wb_object_operator = get_wb_object_operator( ).

    TRY.
        CREATE OBJECT li_object_data_model TYPE ('CL_DRUL_WB_OBJECT_DATA').

        ASSIGN COMPONENT 'CONTENT-SOURCE' OF STRUCTURE <ls_dependency_rule>
               TO <lv_source>.
        ASSERT sy-subrc = 0.

        <lv_source> = mo_files->read_string( 'asdrul' ).

        tadir_insert( iv_package ).

        lv_transport_request = get_transport_req_if_needed( iv_package ).

        IF zif_abapgit_object~exists( ) = abap_true.

          " We need to populate created_at, created_by, because otherwise update  is not possible
          fill_metadata_from_db( CHANGING cs_dependency_rule = <ls_dependency_rule> ).
          li_object_data_model->set_data( <ls_dependency_rule> ).

          CALL METHOD li_wb_object_operator->('IF_WB_OBJECT_OPERATOR~UPDATE')
            EXPORTING
              io_object_data    = li_object_data_model
              transport_request = lv_transport_request.

        ELSE.

          li_object_data_model->set_data( <ls_dependency_rule> ).

          CALL METHOD li_wb_object_operator->('IF_WB_OBJECT_OPERATOR~CREATE')
            EXPORTING
              io_object_data    = li_object_data_model
              data_selection    = 'P' " if_wb_object_data_selection_co=>c_properties
              package           = iv_package
              transport_request = lv_transport_request.

          CALL METHOD li_wb_object_operator->('IF_WB_OBJECT_OPERATOR~UPDATE')
            EXPORTING
              io_object_data    = li_object_data_model
              data_selection    = 'D' " if_wb_object_data_selection_co=>c_data_content
              transport_request = lv_transport_request.

        ENDIF.

        CALL METHOD li_wb_object_operator->('IF_WB_OBJECT_OPERATOR~ACTIVATE').

        corr_insert( iv_package ).

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.