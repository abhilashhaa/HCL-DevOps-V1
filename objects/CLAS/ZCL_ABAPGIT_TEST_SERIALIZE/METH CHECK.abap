  METHOD check.

    DATA: ls_files_item TYPE zcl_abapgit_objects=>ty_serialization.

    ls_files_item = zcl_abapgit_objects=>serialize( is_item     = is_item
                                                    iv_language = zif_abapgit_definitions=>c_english ).

    cl_abap_unit_assert=>assert_not_initial( ls_files_item-files ).
    cl_abap_unit_assert=>assert_equals( act = ls_files_item-item
                                        exp = is_item ).

  ENDMETHOD.