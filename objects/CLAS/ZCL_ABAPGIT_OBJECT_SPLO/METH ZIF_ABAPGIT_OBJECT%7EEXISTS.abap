  METHOD zif_abapgit_object~exists.

    DATA: lv_papart TYPE tsp1d-papart.


    SELECT SINGLE papart INTO lv_papart FROM tsp1d
      WHERE papart = ms_item-obj_name.
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.