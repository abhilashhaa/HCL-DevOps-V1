  METHOD update_package_tree.

    DATA: lt_packages TYPE zif_abapgit_sap_package=>ty_devclass_tt,
          lv_package  LIKE LINE OF lt_packages,
          lv_tree     TYPE dirtree-tname.


    lt_packages = zcl_abapgit_factory=>get_sap_package( iv_package )->list_subpackages( ).
    APPEND iv_package TO lt_packages.

    LOOP AT lt_packages INTO lv_package.
* update package tree for SE80
      lv_tree = 'EU_' && lv_package.
      CALL FUNCTION 'WB_TREE_ACTUALIZE'
        EXPORTING
          tree_name              = lv_tree
          without_crossreference = abap_true
          with_tcode_index       = abap_true.
    ENDLOOP.

  ENDMETHOD.