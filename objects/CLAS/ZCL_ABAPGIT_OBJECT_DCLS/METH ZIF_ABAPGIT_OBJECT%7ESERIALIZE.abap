  METHOD zif_abapgit_object~serialize.

    DATA: lr_data  TYPE REF TO data,
          lo_dcl   TYPE REF TO object,
          lx_error TYPE REF TO cx_root.

    FIELD-SYMBOLS: <lg_data>  TYPE any,
                   <lg_field> TYPE any.


    CREATE DATA lr_data TYPE ('ACM_S_DCLSRC').
    ASSIGN lr_data->* TO <lg_data>.

    TRY.
        CALL METHOD ('CL_ACM_DCL_HANDLER_FACTORY')=>('CREATE')
          RECEIVING
            ro_handler = lo_dcl.

        CALL METHOD lo_dcl->('READ')
          EXPORTING
            iv_dclname = ms_item-obj_name
          IMPORTING
            es_dclsrc  = <lg_data>.

        ASSIGN COMPONENT 'AS4USER' OF STRUCTURE <lg_data> TO <lg_field>.
        ASSERT sy-subrc = 0.
        CLEAR <lg_field>.

        ASSIGN COMPONENT 'AS4DATE' OF STRUCTURE <lg_data> TO <lg_field>.
        ASSERT sy-subrc = 0.
        CLEAR <lg_field>.

        ASSIGN COMPONENT 'AS4TIME' OF STRUCTURE <lg_data> TO <lg_field>.
        ASSERT sy-subrc = 0.
        CLEAR <lg_field>.

        ASSIGN COMPONENT 'CREATED_BY' OF STRUCTURE <lg_data> TO <lg_field>.
        ASSERT sy-subrc = 0.
        CLEAR <lg_field>.

        ASSIGN COMPONENT 'CREATED_DATE' OF STRUCTURE <lg_data> TO <lg_field>.
        ASSERT sy-subrc = 0.
        CLEAR <lg_field>.

        ASSIGN COMPONENT 'AS4LOCAL' OF STRUCTURE <lg_data> TO <lg_field>.
        ASSERT sy-subrc = 0.
        CLEAR <lg_field>.

        ASSIGN COMPONENT 'ABAP_LANGUAGE_VERSION' OF STRUCTURE <lg_data> TO <lg_field>.
        IF sy-subrc = 0.
          CLEAR <lg_field>.
        ENDIF.

        ASSIGN COMPONENT 'SOURCE' OF STRUCTURE <lg_data> TO <lg_field>.
        ASSERT sy-subrc = 0.

        mo_files->add_string( iv_ext = 'asdcls'
                              iv_string = <lg_field> ).

        CLEAR <lg_field>.

        io_xml->add( iv_name = 'DCLS'
                     ig_data = <lg_data> ).

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise( iv_text     = lx_error->get_text( )
                                      ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.