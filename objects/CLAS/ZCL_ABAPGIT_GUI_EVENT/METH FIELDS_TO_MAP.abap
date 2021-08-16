  METHOD fields_to_map.
    FIELD-SYMBOLS <ls_field> LIKE LINE OF it_fields.

    CREATE OBJECT ro_string_map.
    LOOP AT it_fields ASSIGNING <ls_field>.
      ro_string_map->set(
        iv_key = <ls_field>-name
        iv_val = <ls_field>-value ).
    ENDLOOP.
  ENDMETHOD.