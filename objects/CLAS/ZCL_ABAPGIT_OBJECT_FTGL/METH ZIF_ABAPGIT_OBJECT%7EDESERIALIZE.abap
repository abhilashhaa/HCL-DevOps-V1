  METHOD zif_abapgit_object~deserialize.

    DATA:
      lo_toggle TYPE REF TO object,
      lx_error  TYPE REF TO cx_root.

    FIELD-SYMBOLS: <lg_toggle> TYPE data.

    ASSIGN mr_toggle->* TO <lg_toggle>.
    ASSERT sy-subrc = 0.

    io_xml->read(
      EXPORTING
        iv_name = 'FTGL'
      CHANGING
        cg_data = <lg_toggle> ).

    TRY.
        CALL METHOD ('CL_FEATURE_TOGGLE_OBJECT')=>create_toggle_by_content
          EXPORTING
            is_content = <lg_toggle>
          RECEIVING
            ro_toggle  = lo_toggle.

        CALL METHOD lo_toggle->('SAVE').

        tadir_insert( iv_package ).
        corr_insert( iv_package ).

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise(
            iv_text     = lx_error->get_text( )
            ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.