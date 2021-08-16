  METHOD zif_abapgit_object~serialize.

    DATA: lo_ddl           TYPE REF TO object,
          lr_data          TYPE REF TO data,
          lr_data_baseinfo TYPE REF TO data,
          lt_clr_comps     TYPE STANDARD TABLE OF fieldname WITH DEFAULT KEY,
          lx_error         TYPE REF TO cx_root.

    FIELD-SYMBOLS: <lg_data>          TYPE any,
                   <lg_field>         TYPE any,
                   <lv_comp>          LIKE LINE OF lt_clr_comps,
                   <lt_data_baseinfo> TYPE ANY TABLE,
                   <lg_data_baseinfo> TYPE any,
                   <lg_ddlname>       TYPE any,
                   <lg_as4local>      TYPE any.


    TRY.
        CREATE DATA lr_data TYPE ('DDDDLSRCV').
        ASSIGN lr_data->* TO <lg_data>.

        CALL METHOD ('CL_DD_DDL_HANDLER_FACTORY')=>('CREATE')
          RECEIVING
            handler = lo_ddl.

        IF is_baseinfo_supported( ) = abap_true.
          CREATE DATA lr_data_baseinfo TYPE ('IF_DD_DDL_TYPES=>TY_T_BASEINFO_STRING').
          ASSIGN lr_data_baseinfo->* TO <lt_data_baseinfo>.
          ASSIGN lr_data_baseinfo->* TO <lg_data_baseinfo>.

          CALL METHOD lo_ddl->('IF_DD_DDL_HANDLER~READ')
            EXPORTING
              name            = ms_item-obj_name
              get_state       = 'A'
            IMPORTING
              ddddlsrcv_wa    = <lg_data>
              baseinfo_string = <lt_data_baseinfo>.

          LOOP AT <lt_data_baseinfo> ASSIGNING <lg_data_baseinfo>.
            ASSIGN COMPONENT 'DDLNAME' OF STRUCTURE <lg_data_baseinfo> TO <lg_ddlname>.
            ASSERT sy-subrc = 0.

            ASSIGN COMPONENT 'AS4LOCAL' OF STRUCTURE <lg_data_baseinfo> TO <lg_as4local>.
            ASSERT sy-subrc = 0.

            IF <lg_ddlname> = ms_item-obj_name AND <lg_as4local> = 'A'.
              ASSIGN COMPONENT 'BASEINFO_STRING' OF STRUCTURE <lg_data_baseinfo> TO <lg_field>.
              ASSERT sy-subrc = 0.
              mo_files->add_string( iv_ext    = 'baseinfo'
                                    iv_string = <lg_field> ).
              EXIT.
            ENDIF.
          ENDLOOP.
        ELSE.
          CALL METHOD lo_ddl->('IF_DD_DDL_HANDLER~READ')
            EXPORTING
              name         = ms_item-obj_name
              get_state    = 'A'
            IMPORTING
              ddddlsrcv_wa = <lg_data>.
        ENDIF.

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise( iv_text     = lx_error->get_text( )
                                      ix_previous = lx_error ).
    ENDTRY.

    APPEND 'AS4USER' TO lt_clr_comps.
    APPEND 'AS4DATE' TO lt_clr_comps.
    APPEND 'AS4TIME' TO lt_clr_comps.
    APPEND 'ACTFLAG' TO lt_clr_comps.
    APPEND 'CHGFLAG' TO lt_clr_comps.
    APPEND 'ABAP_LANGUAGE_VERSION' TO lt_clr_comps.

    LOOP AT lt_clr_comps ASSIGNING <lv_comp>.
      ASSIGN COMPONENT <lv_comp> OF STRUCTURE <lg_data> TO <lg_field>.
      IF sy-subrc = 0.
        CLEAR <lg_field>.
      ENDIF.
    ENDLOOP.

    ASSIGN COMPONENT 'SOURCE' OF STRUCTURE <lg_data> TO <lg_field>.
    ASSERT sy-subrc = 0.

    mo_files->add_string( iv_ext    = 'asddls'
                          iv_string = <lg_field> ).

    CLEAR <lg_field>.

    io_xml->add( iv_name = 'DDLS'
                 ig_data = <lg_data> ).

  ENDMETHOD.