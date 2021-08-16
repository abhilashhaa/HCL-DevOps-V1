  METHOD parse_form.

    DATA ls_field LIKE LINE OF it_form_fields.

    CREATE OBJECT ro_form_data.

    " temporary, TODO refactor later, after gui_event class is ready, move to on_event
    LOOP AT it_form_fields INTO ls_field.
      ro_form_data->set(
        iv_key = ls_field-name
        iv_val = ls_field-value ).
    ENDLOOP.

    ro_form_data = mo_form->validate_normalize_form_data( ro_form_data ).

  ENDMETHOD.