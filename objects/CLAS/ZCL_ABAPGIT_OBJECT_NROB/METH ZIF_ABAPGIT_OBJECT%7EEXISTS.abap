  METHOD zif_abapgit_object~exists.

    DATA: lv_object TYPE tnro-object.


    SELECT SINGLE object FROM tnro INTO lv_object
      WHERE object = ms_item-obj_name.
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.