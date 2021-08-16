  METHOD is_sap_object_allowed.

    rv_allowed = cl_enh_badi_def_utility=>is_sap_system( ).
    IF rv_allowed = abap_true.
      RETURN.
    ENDIF.

    rv_allowed = zcl_abapgit_exit=>get_instance( )->allow_sap_objects( ).

  ENDMETHOD.