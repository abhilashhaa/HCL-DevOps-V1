  METHOD zif_abapgit_object~exists.

    DATA: lv_objct TYPE tobj-objct.


    SELECT SINGLE objct FROM tobj INTO lv_objct
      WHERE objct = ms_item-obj_name.
    rv_bool = boolc( sy-subrc = 0 ).

  ENDMETHOD.