  METHOD zif_abapgit_oo_object_fnc~generate_locals.

    DATA: lv_program TYPE programm.


    IF lines( it_local_definitions ) > 0.
      lv_program = cl_oo_classname_service=>get_ccdef_name( is_key-clsname ).
      update_report( iv_program = lv_program
                     it_source  = it_local_definitions ).
    ENDIF.

    IF lines( it_local_implementations ) > 0.
      lv_program = cl_oo_classname_service=>get_ccimp_name( is_key-clsname ).
      update_report( iv_program = lv_program
                     it_source  = it_local_implementations ).
    ENDIF.

    IF lines( it_local_macros ) > 0.
      lv_program = cl_oo_classname_service=>get_ccmac_name( is_key-clsname ).
      update_report( iv_program = lv_program
                     it_source  = it_local_macros ).
    ENDIF.

    IF lines( it_local_test_classes ) > 0.
      lv_program = cl_oo_classname_service=>get_ccau_name( is_key-clsname ).
      update_report( iv_program = lv_program
                     it_source  = it_local_test_classes ).
    ENDIF.

  ENDMETHOD.