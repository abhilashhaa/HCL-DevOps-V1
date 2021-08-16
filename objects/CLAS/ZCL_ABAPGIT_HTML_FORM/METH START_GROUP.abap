  METHOD start_group.

    DATA ls_field LIKE LINE OF mt_fields.

    ls_field-type  = c_field_type-field_group.
    ls_field-label = iv_label.
    ls_field-name  = iv_name.

    IF iv_hint IS NOT INITIAL.
      ls_field-hint    = | title="{ iv_hint }"|.
    ENDIF.

    APPEND ls_field TO mt_fields.

    ro_self = me.

  ENDMETHOD.