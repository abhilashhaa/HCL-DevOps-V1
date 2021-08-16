  METHOD get_page_content.

    DATA: lt_content TYPE o2pageline_table,
          lv_string  TYPE string.

    io_page->get_page(
      IMPORTING
        p_content = lt_content
      EXCEPTIONS
        invalid_call = 1
        page_deleted = 2
        OTHERS       = 3 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |WAPA - error from get_page_content| ).
    ENDIF.

    CONCATENATE LINES OF lt_content INTO lv_string SEPARATED BY zif_abapgit_definitions=>c_newline RESPECTING BLANKS.

    rv_content = zcl_abapgit_convert=>string_to_xstring_utf8( lv_string ).

  ENDMETHOD.