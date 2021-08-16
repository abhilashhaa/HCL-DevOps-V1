  METHOD create_regex_set.

    DATA: lo_regex TYPE REF TO cl_abap_regex,
          lt_regex TYPE zif_abapgit_definitions=>ty_string_tt,
          lv_regex LIKE LINE OF lt_regex.

    APPEND '^\s*(CLASS|FORM|MODULE|REPORT|METHOD)\s' TO lt_regex.
    APPEND '^\s*START-OF-' TO lt_regex.
    APPEND '^\s*INITIALIZATION(\s|\.)' TO lt_regex.

    LOOP AT lt_regex INTO lv_regex.
      CREATE OBJECT lo_regex
        EXPORTING
          pattern     = lv_regex
          ignore_case = abap_true.
      APPEND lo_regex TO rt_regex_set.
    ENDLOOP.

  ENDMETHOD.