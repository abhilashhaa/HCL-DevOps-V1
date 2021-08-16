  METHOD zif_abapgit_sap_package~read_parent.

    SELECT SINGLE parentcl FROM tdevc INTO rv_parentcl
      WHERE devclass = mv_package.        "#EC CI_GENBUFF
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Inconsistent package structure! Cannot find parent for { mv_package }| ).
    ENDIF.

  ENDMETHOD.