  METHOD zif_abapgit_object~exists.

    DATA: lv_formname TYPE stxfadm-formname.

    SELECT SINGLE formname FROM stxfadm INTO lv_formname
      WHERE formname = ms_item-obj_name.
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.