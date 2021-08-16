  METHOD zif_abapgit_object~exists.

    DATA: lv_guid TYPE cls_assignment-guid.

    SELECT SINGLE guid FROM cls_assignment INTO lv_guid
      WHERE guid = ms_item-obj_name.
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.