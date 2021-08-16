  METHOD get_code_inspector.

    DATA: ls_code_inspector LIKE LINE OF gt_code_inspector.
    FIELD-SYMBOLS: <ls_code_inspector> TYPE ty_code_inspector.

    READ TABLE gt_code_inspector ASSIGNING <ls_code_inspector>
      WITH TABLE KEY package = iv_package.
    IF sy-subrc <> 0.
      ls_code_inspector-package = iv_package.

      CREATE OBJECT ls_code_inspector-instance TYPE zcl_abapgit_code_inspector
        EXPORTING
          iv_package = iv_package.

      INSERT ls_code_inspector
             INTO TABLE gt_code_inspector
             ASSIGNING <ls_code_inspector>.

    ENDIF.

    ri_code_inspector = <ls_code_inspector>-instance.

  ENDMETHOD.