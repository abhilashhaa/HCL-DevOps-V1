  METHOD zif_abapgit_object~serialize.

    DATA:
      li_wb_object_operator TYPE REF TO object,
      li_object_data_model  TYPE REF TO if_wb_object_data_model,
      lx_error              TYPE REF TO cx_root,
      lv_source             TYPE string.

    FIELD-SYMBOLS:
      <ls_dependency_rule> TYPE any,
      <lv_source>          TYPE string.

    ASSIGN mr_dependency_rule->* TO <ls_dependency_rule>.
    ASSERT sy-subrc = 0.

    li_wb_object_operator = get_wb_object_operator( ).

    TRY.
        CALL METHOD li_wb_object_operator->('IF_WB_OBJECT_OPERATOR~READ')
          EXPORTING
            version        = 'A'
          IMPORTING
            data           = <ls_dependency_rule>
            eo_object_data = li_object_data_model.

        ASSIGN COMPONENT 'CONTENT-SOURCE' OF STRUCTURE <ls_dependency_rule>
               TO <lv_source>.
        ASSERT sy-subrc = 0.

        lv_source = <lv_source>.

        clear_fields( CHANGING cs_dependency_rule = <ls_dependency_rule> ).

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

    io_xml->add(
        iv_name = 'DRUL'
        ig_data = <ls_dependency_rule> ).

    mo_files->add_string(
        iv_ext    = 'asdrul'
        iv_string = lv_source ).

  ENDMETHOD.