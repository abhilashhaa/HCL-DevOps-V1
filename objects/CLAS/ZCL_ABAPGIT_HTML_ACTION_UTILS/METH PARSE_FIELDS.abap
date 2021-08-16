  METHOD parse_fields.

    DATA:
      lt_substrings TYPE string_table,
      ls_field      LIKE LINE OF rt_fields.

    FIELD-SYMBOLS <lv_substring> LIKE LINE OF lt_substrings.

    SPLIT iv_string AT '&' INTO TABLE lt_substrings.

    LOOP AT lt_substrings ASSIGNING <lv_substring>.

      CLEAR ls_field.
      <lv_substring> = unescape( <lv_substring> ).
      " On attempt to change unescaping -> run unit tests to check !

      ls_field-name = substring_before(
        val = <lv_substring>
        sub = '=' ).

      ls_field-value = substring_after(
        val = <lv_substring>
        sub = '=' ).

      IF ls_field IS INITIAL. " Not a field with proper structure
        CONTINUE.
      ENDIF.

      APPEND ls_field TO rt_fields.

    ENDLOOP.

  ENDMETHOD.