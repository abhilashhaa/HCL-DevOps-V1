  METHOD zif_abapgit_object~exists.

    DATA: lv_pack_name TYPE intf-pack_name,
          lv_main_pack TYPE tdevc-mainpack.


    SELECT SINGLE pack_name FROM intf INTO lv_pack_name
      WHERE intf_name = ms_item-obj_name.
    rv_bool = boolc( sy-subrc = 0 ).

    IF rv_bool = abap_true.
      SELECT SINGLE mainpack FROM tdevc INTO lv_main_pack
        WHERE devclass = lv_pack_name.                  "#EC CI_GENBUFF
      rv_bool = boolc( sy-subrc = 0 ).
    ENDIF.

  ENDMETHOD.