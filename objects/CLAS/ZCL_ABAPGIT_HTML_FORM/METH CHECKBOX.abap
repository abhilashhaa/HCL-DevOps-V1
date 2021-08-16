  METHOD checkbox.

    DATA ls_field LIKE LINE OF mt_fields.

    ls_field-type  = c_field_type-checkbox.
    ls_field-name  = iv_name.
    ls_field-label = iv_label.

    IF iv_hint IS NOT INITIAL.
      ls_field-hint    = | title="{ iv_hint }"|.
    ENDIF.

    APPEND ls_field TO mt_fields.

    ro_self = me.

  ENDMETHOD.