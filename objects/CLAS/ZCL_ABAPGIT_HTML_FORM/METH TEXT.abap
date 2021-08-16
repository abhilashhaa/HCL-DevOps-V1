  METHOD text.

    DATA ls_field LIKE LINE OF mt_fields.

    ls_field-type       = c_field_type-text.
    ls_field-name       = iv_name.
    ls_field-label      = iv_label.
    ls_field-upper_case = iv_upper_case.

    IF iv_hint IS NOT INITIAL.
      ls_field-hint    = | title="{ iv_hint }"|.
    ENDIF.

    IF iv_side_action IS NOT INITIAL AND mv_form_id IS NOT INITIAL.
      ls_field-item_class = 'with-command'.
      ls_field-side_action = iv_side_action.
      ls_field-dblclick = | ondblclick="document.getElementById('{ mv_form_id
        }').action = 'sapevent:{ iv_side_action
        }'; document.getElementById('{ mv_form_id
        }').submit()"|.
    ENDIF.

    IF iv_required = abap_true.
      ls_field-required = ' <em>*</em>'.
    ENDIF.

    IF iv_placeholder IS NOT INITIAL.
      ls_field-placeholder = | placeholder="{ iv_placeholder }"|.
    ENDIF.

    APPEND ls_field TO mt_fields.

    ro_self = me.

  ENDMETHOD.