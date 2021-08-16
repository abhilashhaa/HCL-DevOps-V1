  METHOD zif_abapgit_object~jump.

    DATA: lv_display_only TYPE scpr_txt20,
          lv_bcset_id     TYPE scpr_id.

    lv_display_only = abap_false.
    lv_bcset_id     = ms_item-obj_name.

    EXPORT scpr3_display_only = lv_display_only
           scpr3_bcset_id     = lv_bcset_id
        TO MEMORY ID 'SCPR3_PARAMETER'.

    SUBMIT scpr3 AND RETURN.

  ENDMETHOD.