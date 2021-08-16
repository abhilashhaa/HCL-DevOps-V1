  METHOD itf_to_string.

    CONSTANTS: lc_format_section TYPE string VALUE 'U1'.

    DATA:
      lt_stream      TYPE TABLE OF tdline,
      lt_string      TYPE TABLE OF string,
      lv_string      LIKE LINE OF lt_string,
      lt_itf         TYPE tline_tab,
      lv_has_content TYPE abap_bool,
      lv_tabix_from  TYPE syst-tabix,
      lv_tabix_to    TYPE syst-tabix.

    FIELD-SYMBOLS: <ls_itf_section>      TYPE tline,
                   <ls_itf_section_item> TYPE tline.

    lt_itf = it_itf.

    " You should remember that we replace the U1 format because
    " that preserves the section header of longtexts.
    LOOP AT lt_itf ASSIGNING <ls_itf_section>
                   WHERE tdformat = lc_format_section.

      CLEAR:
        lv_has_content,
        lv_tabix_to.

      lv_tabix_from = sy-tabix.

      LOOP AT lt_itf ASSIGNING <ls_itf_section_item>
                     FROM sy-tabix + 1.

        IF <ls_itf_section_item>-tdformat = lc_format_section.
          lv_tabix_to = sy-tabix.
          EXIT.
        ELSEIF <ls_itf_section_item>-tdline IS NOT INITIAL.
          lv_has_content = abap_true.
        ENDIF.

      ENDLOOP.

      IF lv_has_content = abap_false.
        remove_empty_section(
          EXPORTING
            iv_tabix_from = lv_tabix_from
            iv_tabix_to   = lv_tabix_to
          CHANGING
            ct_itf        = lt_itf ).
        CONTINUE.
      ENDIF.

      replace_section_head_with_text( CHANGING cs_itf = <ls_itf_section> ).

    ENDLOOP.

    CALL FUNCTION 'CONVERT_ITF_TO_STREAM_TEXT'
      EXPORTING
        lf           = 'X'
      IMPORTING
        stream_lines = lt_string
      TABLES
        itf_text     = lt_itf
        text_stream  = lt_stream.

    LOOP AT lt_string INTO lv_string.
      IF sy-tabix = 1.
        rv_result = lv_string.
      ELSE.
        CONCATENATE rv_result lv_string
                    INTO rv_result
                    SEPARATED BY cl_abap_char_utilities=>newline.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.