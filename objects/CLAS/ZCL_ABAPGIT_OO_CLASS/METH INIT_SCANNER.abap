  METHOD init_scanner.

    DATA: lx_exc       TYPE REF TO cx_root,
          lv_message   TYPE string,
          lv_classname TYPE abap_abstypename.
    FIELD-SYMBOLS: <lv_line> TYPE i.

    TRY.
        ro_scanner = cl_oo_source_scanner_class=>create_class_scanner(
          clif_name = iv_name
          source    = it_source ).
        ro_scanner->scan( ).
      CATCH cx_clif_scan_error.
        zcx_abapgit_exception=>raise( 'error initializing CLAS scanner' ).
      CATCH cx_root INTO lx_exc.
        lv_classname = cl_abap_classdescr=>get_class_name( lx_exc ).
        IF lv_classname = '\CLASS=CX_OO_CLIF_SCAN_ERROR_DETAIL'.
          ASSIGN lx_exc->('SOURCE_POSITION-LINE') TO <lv_line>.
          ASSERT sy-subrc = 0.
          lv_message = |{ lx_exc->get_text( ) }, line { <lv_line> }|.
        ELSE.
          lv_message = lx_exc->get_text( ).
        ENDIF.
        zcx_abapgit_exception=>raise( lv_message ).
    ENDTRY.

  ENDMETHOD.