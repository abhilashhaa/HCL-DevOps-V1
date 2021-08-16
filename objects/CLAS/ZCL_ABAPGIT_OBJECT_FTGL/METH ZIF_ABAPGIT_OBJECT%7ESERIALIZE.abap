  METHOD zif_abapgit_object~serialize.

    DATA:
      lx_error  TYPE REF TO cx_root,
      lo_toggle TYPE REF TO object.

    FIELD-SYMBOLS: <lg_toggle> TYPE data.

    ASSIGN mr_toggle->* TO <lg_toggle>.
    ASSERT sy-subrc = 0.

    TRY.
        CALL METHOD ('CL_FEATURE_TOGGLE_OBJECT')=>create_toggle_by_id
          EXPORTING
            iv_toggle_id = mv_toggle_id
          RECEIVING
            ro_toggle    = lo_toggle.

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

    CALL METHOD lo_toggle->('GET_CONTENT')
      RECEIVING
        rs_content = <lg_toggle>.

    clear_field( EXPORTING iv_fieldname = 'HEADER-OWNER'        CHANGING cg_header = <lg_toggle> ).
    clear_field( EXPORTING iv_fieldname = 'HEADER-CREATED_DATE' CHANGING cg_header = <lg_toggle> ).
    clear_field( EXPORTING iv_fieldname = 'HEADER-CREATED_TIME' CHANGING cg_header = <lg_toggle> ).
    clear_field( EXPORTING iv_fieldname = 'HEADER-CHANGEDBY   ' CHANGING cg_header = <lg_toggle> ).
    clear_field( EXPORTING iv_fieldname = 'HEADER-CHANGED_DATE' CHANGING cg_header = <lg_toggle> ).
    clear_field( EXPORTING iv_fieldname = 'HEADER-CHANGED_TIME' CHANGING cg_header = <lg_toggle> ).

    io_xml->add(
        iv_name = 'FTGL'
        ig_data = <lg_toggle> ).

  ENDMETHOD.