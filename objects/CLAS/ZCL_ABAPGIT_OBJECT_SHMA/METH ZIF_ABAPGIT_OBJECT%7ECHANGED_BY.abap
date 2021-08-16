  METHOD zif_abapgit_object~changed_by.

    SELECT SINGLE chg_user
      FROM shma_attributes
      INTO rv_user
      WHERE area_name = ms_item-obj_name.
    IF sy-subrc <> 0.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.