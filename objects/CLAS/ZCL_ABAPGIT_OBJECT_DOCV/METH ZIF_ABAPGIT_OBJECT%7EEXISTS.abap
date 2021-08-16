  METHOD zif_abapgit_object~exists.

    DATA: lv_id     TYPE dokhl-id,
          lv_object TYPE dokhl-object.


    lv_id = ms_item-obj_name(2).
    lv_object = ms_item-obj_name+2.

    SELECT SINGLE id FROM dokil INTO lv_id
      WHERE id     = lv_id
        AND object = lv_object.                         "#EC CI_GENBUFF

    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.