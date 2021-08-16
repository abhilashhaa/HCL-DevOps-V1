  METHOD zif_abapgit_object~changed_by.

    DATA: lv_transaction_variant TYPE utcvariant.

    lv_transaction_variant = ms_item-obj_name.

    SELECT SINGLE chuser
    FROM shdtvciu
    INTO rv_user
    WHERE tcvariant = lv_transaction_variant.
    IF sy-subrc <> 0
    OR rv_user IS INITIAL.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.