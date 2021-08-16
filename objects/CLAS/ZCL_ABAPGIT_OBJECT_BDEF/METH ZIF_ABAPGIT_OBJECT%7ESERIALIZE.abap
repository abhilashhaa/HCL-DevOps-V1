  METHOD zif_abapgit_object~serialize.

    DATA:
      li_object_data_model  TYPE REF TO if_wb_object_data_model,
      li_wb_object_operator TYPE REF TO object,
      lx_error              TYPE REF TO cx_root,
      lv_source             TYPE string.

    FIELD-SYMBOLS:
      <ls_behaviour_definition> TYPE any,
      <lv_source>               TYPE string.

    ASSIGN mr_behaviour_definition->* TO <ls_behaviour_definition>.
    ASSERT sy-subrc = 0.

    li_wb_object_operator = get_wb_object_operator( ).

    TRY.
        CALL METHOD li_wb_object_operator->('IF_WB_OBJECT_OPERATOR~READ')
          EXPORTING
            version        = 'A'
          IMPORTING
            data           = <ls_behaviour_definition>
            eo_object_data = li_object_data_model.

        ASSIGN COMPONENT 'CONTENT-SOURCE' OF STRUCTURE <ls_behaviour_definition>
               TO <lv_source>.
        ASSERT sy-subrc = 0.

        lv_source = <lv_source>.

        clear_fields( CHANGING cs_behaviour_definition = <ls_behaviour_definition> ).

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

    io_xml->add(
        iv_name = 'BDEF'
        ig_data = <ls_behaviour_definition> ).

    mo_files->add_string(
        iv_ext    = 'asbdef'
        iv_string = lv_source ).

  ENDMETHOD.