  METHOD find_content.

    DATA: lv_filename TYPE string,
          lt_files    TYPE zif_abapgit_definitions=>ty_files_tt.

    FIELD-SYMBOLS: <ls_file> LIKE LINE OF lt_files.


    lv_filename = get_filename( iv_url ).

    lv_filename = build_filename( lv_filename ).

    lt_files = mo_files->get_files( ).

    READ TABLE lt_files ASSIGNING <ls_file> WITH KEY filename = lv_filename.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'SMIM, file not found' ).
    ENDIF.

    rv_content = <ls_file>-data.

  ENDMETHOD.