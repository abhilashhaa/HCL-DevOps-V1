  METHOD get_parent.
    DATA: ls_parent LIKE LINE OF mt_parent.

    "Determine Parent Package
    READ TABLE mt_parent INTO ls_parent
      WITH TABLE KEY devclass = iv_package.
    IF sy-subrc <> 0.
      rv_parent = zcl_abapgit_factory=>get_sap_package( iv_package )->read_parent( ).
      ls_parent-devclass = iv_package.
      ls_parent-parentcl = rv_parent.
      INSERT ls_parent INTO TABLE mt_parent.
    ELSE.
      rv_parent = ls_parent-parentcl.
    ENDIF.
  ENDMETHOD.