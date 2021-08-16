  METHOD add_field.

    FIELD-SYMBOLS: <ls_field> LIKE LINE OF ct_fields.

    APPEND INITIAL LINE TO ct_fields ASSIGNING <ls_field>.
    <ls_field>-tabname    = iv_tabname.
    <ls_field>-fieldname  = iv_fieldname.
    <ls_field>-fieldtext  = iv_fieldtext.
    <ls_field>-value      = iv_value.
    <ls_field>-field_attr = iv_field_attr.
    <ls_field>-field_obl  = iv_obligatory.

  ENDMETHOD.