  METHOD zif_abapgit_oo_object_fnc~create.
    DATA: lt_vseoattrib TYPE seoo_attributes_r.
    FIELD-SYMBOLS: <lv_clsname> TYPE seoclsname.

    ASSIGN COMPONENT 'CLSNAME' OF STRUCTURE cg_properties TO <lv_clsname>.
    ASSERT sy-subrc = 0.

    lt_vseoattrib = convert_attrib_to_vseoattrib(
                      iv_clsname    = <lv_clsname>
                      it_attributes = it_attributes ).

    TRY.
        CALL FUNCTION 'SEO_INTERFACE_CREATE_COMPLETE'
          EXPORTING
            devclass        = iv_package
            overwrite       = iv_overwrite
            suppress_dialog = abap_true " Parameter missing in 702
          CHANGING
            interface       = cg_properties
            attributes      = lt_vseoattrib
          EXCEPTIONS
            existing        = 1
            is_class        = 2
            db_error        = 3
            component_error = 4
            no_access       = 5
            other           = 6
            OTHERS          = 7.
      CATCH cx_sy_dyn_call_param_not_found.
        CALL FUNCTION 'SEO_INTERFACE_CREATE_COMPLETE'
          EXPORTING
            devclass        = iv_package
            overwrite       = iv_overwrite
          CHANGING
            interface       = cg_properties
            attributes      = lt_vseoattrib
          EXCEPTIONS
            existing        = 1
            is_class        = 2
            db_error        = 3
            component_error = 4
            no_access       = 5
            other           = 6
            OTHERS          = 7.
    ENDTRY.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from SEO_INTERFACE_CREATE_COMPLETE. Subrc = { sy-subrc }| ).
    ENDIF.
  ENDMETHOD.