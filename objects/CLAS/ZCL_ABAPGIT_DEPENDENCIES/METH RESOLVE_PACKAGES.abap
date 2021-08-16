  METHOD resolve_packages.

    DATA: lt_subpackages TYPE zif_abapgit_sap_package=>ty_devclass_tt.

    FIELD-SYMBOLS: <ls_tadir>            LIKE LINE OF ct_tadir,
                   <lv_subpackage>       LIKE LINE OF lt_subpackages,
                   <ls_tadir_subpackage> LIKE LINE OF ct_tadir.

    " List subpackage before corresponding superpackage

    LOOP AT ct_tadir ASSIGNING <ls_tadir>
                     WHERE object = 'DEVC'.

      lt_subpackages = zcl_abapgit_factory=>get_sap_package( |{ <ls_tadir>-obj_name }| )->list_subpackages( ).

      LOOP AT lt_subpackages ASSIGNING <lv_subpackage>.

        READ TABLE ct_tadir ASSIGNING <ls_tadir_subpackage>
                            WITH KEY object   = 'DEVC'
                                     obj_name = <lv_subpackage>.
        IF sy-subrc = 0.
          <ls_tadir_subpackage>-korrnum = condense( |{ <ls_tadir_subpackage>-korrnum - 1 }| ).
        ENDIF.

      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.