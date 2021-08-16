  METHOD zif_abapgit_object~exists.

    DATA: lv_area_name TYPE shm_area_name.

    SELECT SINGLE area_name
           FROM shma_attributes
           INTO lv_area_name
           WHERE area_name = ms_item-obj_name.

    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.