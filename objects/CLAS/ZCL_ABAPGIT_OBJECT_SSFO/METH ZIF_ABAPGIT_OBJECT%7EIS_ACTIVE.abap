  METHOD zif_abapgit_object~is_active.

    DATA: lv_ssfo_formname TYPE tdsfname.

    lv_ssfo_formname = ms_item-obj_name.

    CALL FUNCTION 'SSF_STATUS_INFO'
      EXPORTING
        i_formname = lv_ssfo_formname
      IMPORTING
        o_inactive = ms_item-inactive.

    rv_active = boolc( ms_item-inactive = abap_false ).

  ENDMETHOD.