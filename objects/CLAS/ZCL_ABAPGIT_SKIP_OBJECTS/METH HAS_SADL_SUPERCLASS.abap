  METHOD has_sadl_superclass.

    DATA: li_oo_functions TYPE REF TO zif_abapgit_oo_object_fnc,
          lv_class_name   TYPE seoclsname,
          lv_superclass   TYPE seoclsname.


    li_oo_functions = zcl_abapgit_oo_factory=>make( is_class-object ).
    lv_class_name = is_class-obj_name.
    lv_superclass = li_oo_functions->read_superclass( lv_class_name ).
    IF lv_superclass = 'CL_SADL_GTK_EXPOSURE_MPC'.
      rv_return = abap_true.
    ENDIF.

  ENDMETHOD.