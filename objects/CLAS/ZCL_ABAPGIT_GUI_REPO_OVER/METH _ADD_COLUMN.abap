  METHOD _add_column.

    FIELD-SYMBOLS <ls_col> LIKE LINE OF mt_col_spec.
    APPEND INITIAL LINE TO mt_col_spec ASSIGNING <ls_col>.
    <ls_col>-display_name = iv_display_name.
    <ls_col>-tech_name = iv_tech_name.
    <ls_col>-title = iv_title.
    <ls_col>-css_class = iv_css_class.
    <ls_col>-add_tz = iv_add_tz.
  ENDMETHOD.