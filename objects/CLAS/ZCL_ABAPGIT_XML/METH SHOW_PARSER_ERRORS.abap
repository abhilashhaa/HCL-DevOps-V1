  METHOD show_parser_errors.

    DATA lv_error TYPE i.
    DATA lv_column TYPE string.
    DATA lv_line TYPE string.
    DATA lv_reason TYPE string.
    DATA lv_txt1 TYPE string.
    DATA lv_txt2 TYPE string.
    DATA lv_txt3 TYPE string.
    DATA lv_txt4 TYPE string.
    DATA lv_times TYPE i.
    DATA li_error TYPE REF TO if_ixml_parse_error.

    lv_times = ii_parser->num_errors( ).

    DO lv_times TIMES.
      lv_error = sy-index - 1.
      li_error = ii_parser->get_error( lv_error ).

      lv_column = li_error->get_column( ).
      lv_line   = li_error->get_line( ).
      lv_reason = li_error->get_reason( ).

      IF mv_filename IS NOT INITIAL.
        lv_txt1 = |File: { mv_filename }|.
        lv_txt2 = |Column: { lv_column }|.
        lv_txt3 = |Line: { lv_line }|.
        lv_txt4 = lv_reason.
      ELSE.
        lv_txt1 = |Column: { lv_column }|.
        lv_txt2 = |Line: { lv_line }|.
        lv_txt3 = lv_reason.
        CLEAR lv_txt4.
      ENDIF.

      CALL FUNCTION 'POPUP_TO_INFORM'
        EXPORTING
          titel = 'Error from XML parser'
          txt1  = lv_txt1
          txt2  = lv_txt2
          txt3  = lv_txt3
          txt4  = lv_txt4.
    ENDDO.

  ENDMETHOD.