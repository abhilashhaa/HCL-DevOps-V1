  METHOD field_keys_to_upper.

    FIELD-SYMBOLS <ls_field> LIKE LINE OF ct_fields.

    LOOP AT ct_fields ASSIGNING <ls_field>.
      <ls_field>-name = to_upper( <ls_field>-name ).
    ENDLOOP.

  ENDMETHOD.