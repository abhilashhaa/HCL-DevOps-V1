  METHOD zif_abapgit_object~exists.

    DATA lv_changedate TYPE vcldir-changedate.

    SELECT SINGLE changedate INTO lv_changedate FROM vcldir
      WHERE vclname = ms_item-obj_name.

    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.