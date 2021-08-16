  METHOD get_sap_package.

    DATA: ls_sap_package TYPE ty_sap_package.
    FIELD-SYMBOLS: <ls_sap_package> TYPE ty_sap_package.

    READ TABLE gt_sap_package ASSIGNING <ls_sap_package>
                              WITH TABLE KEY package = iv_package.
    IF sy-subrc <> 0.

      ls_sap_package-package = iv_package.
      CREATE OBJECT ls_sap_package-instance TYPE zcl_abapgit_sap_package
        EXPORTING
          iv_package = iv_package.

      INSERT ls_sap_package
             INTO TABLE gt_sap_package
             ASSIGNING <ls_sap_package>.

    ENDIF.

    ri_sap_package = <ls_sap_package>-instance.

  ENDMETHOD.