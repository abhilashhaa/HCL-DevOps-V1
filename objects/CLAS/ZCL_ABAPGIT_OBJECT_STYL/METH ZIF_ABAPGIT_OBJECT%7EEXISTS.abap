  METHOD zif_abapgit_object~exists.

    DATA: ls_style TYPE ty_style,
          lv_name  TYPE itcda-tdstyle,
          lv_found TYPE abap_bool.


    lv_name = ms_item-obj_name.

    CALL FUNCTION 'READ_STYLE'
      EXPORTING
        style      = lv_name
      IMPORTING
        found      = lv_found
      TABLES
        paragraphs = ls_style-paragraphs
        strings    = ls_style-strings
        tabs       = ls_style-tabs.

    rv_bool = boolc( lv_found = abap_true ).

  ENDMETHOD.