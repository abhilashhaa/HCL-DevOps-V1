  METHOD _sort_tdlines_by_windows.
    DATA lt_lines        TYPE tyt_lines.
    DATA ls_lines        LIKE LINE OF lt_lines.
    DATA ls_form_windows LIKE LINE OF ct_form_windows.
    DATA lv_elt_windows  TYPE tdformat VALUE '/W'.
    DATA lv_firstloop    TYPE abap_bool.

    lt_lines = ct_lines.
    CLEAR ct_lines.

    SORT ct_form_windows BY tdwindow.

    LOOP AT ct_form_windows INTO ls_form_windows.
      lv_firstloop = abap_true.
      READ TABLE lt_lines INTO ls_lines WITH KEY tdformat = lv_elt_windows
                                                 tdline   = ls_form_windows-tdwindow.
      IF sy-subrc <> 0.
        CONTINUE. " current loop
      ENDIF.
      LOOP AT lt_lines INTO ls_lines FROM sy-tabix.
        IF lv_firstloop = abap_false AND
           ls_lines-tdformat = lv_elt_windows.
          EXIT.
        ENDIF.
        APPEND ls_lines TO ct_lines.
        lv_firstloop = abap_false.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.