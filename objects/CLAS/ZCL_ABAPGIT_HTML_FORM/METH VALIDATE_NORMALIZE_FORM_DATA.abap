  METHOD validate_normalize_form_data.

    DATA ls_field LIKE LINE OF mt_fields.
    FIELD-SYMBOLS <ls_entry> LIKE LINE OF io_form_data->mt_entries.

    CREATE OBJECT ro_form_data.

    LOOP AT io_form_data->mt_entries ASSIGNING <ls_entry>.
      READ TABLE mt_fields INTO ls_field WITH KEY by_name COMPONENTS name = <ls_entry>-k.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( |Unexpected form field [{ <ls_entry>-k }]| ).
      ENDIF.

      IF ls_field-type = c_field_type-checkbox.
        ro_form_data->set(
          iv_key = <ls_entry>-k
          iv_val = boolc( <ls_entry>-v = 'on' ) ).
      ELSEIF ls_field-type = c_field_type-text AND ls_field-upper_case = abap_true.
        ro_form_data->set(
          iv_key = <ls_entry>-k
          iv_val = to_upper( <ls_entry>-v ) ).
      ELSE.
        ro_form_data->set(
          iv_key = <ls_entry>-k
          iv_val = <ls_entry>-v ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.