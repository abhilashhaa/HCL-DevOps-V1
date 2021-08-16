  METHOD zif_abapgit_object~delete.

    DELETE FROM tsp1t WHERE papart = ms_item-obj_name. "#EC CI_NOFIRST "#EC CI_SUBRC
    DELETE FROM tsp1d WHERE papart = ms_item-obj_name.    "#EC CI_SUBRC
    DELETE FROM tsp0p WHERE pdpaper = ms_item-obj_name.   "#EC CI_SUBRC

  ENDMETHOD.