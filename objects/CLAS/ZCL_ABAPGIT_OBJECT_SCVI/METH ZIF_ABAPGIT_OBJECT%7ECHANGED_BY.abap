  METHOD zif_abapgit_object~changed_by.

    DATA: lv_screen_variant TYPE scvariant.

    lv_screen_variant = ms_item-obj_name.

    SELECT SINGLE chuser
    FROM shdsvci
    INTO rv_user
    WHERE scvariant = lv_screen_variant.
    IF sy-subrc <> 0
    OR rv_user IS INITIAL.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.