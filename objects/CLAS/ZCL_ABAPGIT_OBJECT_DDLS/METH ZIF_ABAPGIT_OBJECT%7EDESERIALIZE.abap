  METHOD zif_abapgit_object~deserialize.

    DATA:
      lo_ddl           TYPE REF TO object,
      lr_data          TYPE REF TO data,
      lr_data_baseinfo TYPE REF TO data,
      lx_error         TYPE REF TO cx_root.

    FIELD-SYMBOLS:
      <lg_data>             TYPE any,
      <lg_data_baseinfo>    TYPE any,
      <lg_source>           TYPE any,
      <lg_baseinfo_string>  TYPE any,
      <lg_baseinfo_ddlname> TYPE any.

    TRY.
        CREATE DATA lr_data TYPE ('DDDDLSRCV').
        ASSIGN lr_data->* TO <lg_data>.

        io_xml->read( EXPORTING iv_name = 'DDLS'
                      CHANGING cg_data  = <lg_data> ).

        ASSIGN COMPONENT 'SOURCE' OF STRUCTURE <lg_data> TO <lg_source>.
        ASSERT sy-subrc = 0.
        <lg_source> = mo_files->read_string( 'asddls' ).

        CALL METHOD ('CL_DD_DDL_HANDLER_FACTORY')=>('CREATE')
          RECEIVING
            handler = lo_ddl.

        IF is_baseinfo_supported( ) = abap_true.
          CREATE DATA lr_data_baseinfo TYPE ('IF_DD_DDL_TYPES=>TY_S_BASEINFO_STRING_SAVE').
          ASSIGN lr_data_baseinfo->* TO <lg_data_baseinfo>.

          ASSIGN COMPONENT 'BASEINFO_STRING' OF STRUCTURE <lg_data_baseinfo> TO <lg_baseinfo_string>.
          ASSERT sy-subrc = 0.

          <lg_baseinfo_string> = read_baseinfo( ).

          ASSIGN COMPONENT 'DDLNAME' OF STRUCTURE <lg_data_baseinfo> TO <lg_baseinfo_ddlname>.
          ASSERT sy-subrc = 0.
          <lg_baseinfo_ddlname> = ms_item-obj_name.

          CALL METHOD lo_ddl->('IF_DD_DDL_HANDLER~SAVE')
            EXPORTING
              name            = ms_item-obj_name
              put_state       = 'N'
              ddddlsrcv_wa    = <lg_data>
              baseinfo_string = <lg_data_baseinfo>.
        ELSE.
          CALL METHOD lo_ddl->('IF_DD_DDL_HANDLER~SAVE')
            EXPORTING
              name         = ms_item-obj_name
              put_state    = 'N'
              ddddlsrcv_wa = <lg_data>.
        ENDIF.

        CALL METHOD lo_ddl->('IF_DD_DDL_HANDLER~WRITE_TADIR')
          EXPORTING
            objectname = ms_item-obj_name
            devclass   = iv_package
            prid       = 0.

        corr_insert( iv_package ).

      CATCH cx_root INTO lx_error.
        CALL METHOD lo_ddl->('IF_DD_DDL_HANDLER~DELETE')
          EXPORTING
            name = ms_item-obj_name
            prid = 0.

        zcx_abapgit_exception=>raise( iv_text     = lx_error->get_text( )
                                      ix_previous = lx_error ).
    ENDTRY.

    zcl_abapgit_objects_activation=>add_item( ms_item ).

  ENDMETHOD.