  METHOD set_code_inspector.

    DATA: ls_code_inspector LIKE LINE OF zcl_abapgit_factory=>gt_code_inspector.
    FIELD-SYMBOLS: <ls_code_inspector> LIKE LINE OF zcl_abapgit_factory=>gt_code_inspector.

    READ TABLE zcl_abapgit_factory=>gt_code_inspector
         ASSIGNING <ls_code_inspector>
         WITH TABLE KEY package = iv_package.
    IF sy-subrc <> 0.

      ls_code_inspector-package = iv_package.

      INSERT ls_code_inspector
             INTO TABLE zcl_abapgit_factory=>gt_code_inspector
             ASSIGNING <ls_code_inspector>.

    ENDIF.

    <ls_code_inspector>-instance = ii_code_inspector.

  ENDMETHOD.