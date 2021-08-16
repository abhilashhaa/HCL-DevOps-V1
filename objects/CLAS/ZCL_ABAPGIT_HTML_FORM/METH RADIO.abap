  METHOD radio.

    DATA ls_field LIKE LINE OF mt_fields.

    ls_field-type  = c_field_type-radio.
    ls_field-name  = iv_name.
    ls_field-label = iv_label.
    ls_field-default_value = iv_default_value.

    IF iv_hint IS NOT INITIAL.
      ls_field-hint    = | title="{ iv_hint }"|.
    ENDIF.

    APPEND ls_field TO mt_fields.

    ro_self = me.

  ENDMETHOD.