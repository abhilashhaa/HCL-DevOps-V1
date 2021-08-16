  METHOD option.

    FIELD-SYMBOLS <ls_last> LIKE LINE OF mt_fields.
    DATA ls_option LIKE LINE OF <ls_last>-subitems.
    DATA lv_size TYPE i.

    lv_size = lines( mt_fields ).
    ASSERT lv_size > 0. " Exception ? Maybe add zcx_no_check ?

    READ TABLE mt_fields INDEX lv_size ASSIGNING <ls_last>.
    ASSERT sy-subrc = 0.
    ASSERT <ls_last>-type = c_field_type-radio. " Or dropdown - TODO in future

    ls_option-label = iv_label.
    ls_option-value = iv_value.

    APPEND ls_option TO <ls_last>-subitems.

    ro_self = me.

  ENDMETHOD.