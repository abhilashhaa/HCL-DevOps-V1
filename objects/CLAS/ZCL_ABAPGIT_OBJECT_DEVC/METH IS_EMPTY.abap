  METHOD is_empty.

    DATA: lv_object_name TYPE tadir-obj_name,
          lt_subpackages TYPE zif_abapgit_sap_package=>ty_devclass_tt.

    lt_subpackages = zcl_abapgit_factory=>get_sap_package( iv_package_name )->list_subpackages( ).

    IF lines( lt_subpackages ) > 0.
      rv_is_empty = abap_false.
      RETURN.
    ENDIF.

    SELECT SINGLE obj_name
           FROM tadir
           INTO lv_object_name
           WHERE pgmid = 'R3TR'
           AND NOT ( object = 'DEVC' AND obj_name = iv_package_name )
           AND devclass = iv_package_name.
    rv_is_empty = boolc( sy-subrc <> 0 ).

  ENDMETHOD.