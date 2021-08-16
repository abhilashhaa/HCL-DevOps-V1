  PRIVATE SECTION.

    CONSTANTS: c_interface_name TYPE seoclsname VALUE 'ZIF_APACK_MANIFEST' ##NO_TEXT.

    METHODS:
      interface_exists RETURNING VALUE(rv_interface_exists) TYPE abap_bool,
      interface_valid RETURNING VALUE(rv_interface_valid) TYPE abap_bool,
      create_interface RAISING zcx_abapgit_exception,
      add_interface_source_classic IMPORTING is_clskey TYPE seoclskey
                                   RAISING   zcx_abapgit_exception,
      add_interface_source IMPORTING is_clskey TYPE seoclskey
                           RAISING   zcx_abapgit_exception,
      get_interface_source RETURNING VALUE(rt_source) TYPE zif_abapgit_definitions=>ty_string_tt,
      add_intf_source_and_activate RAISING zcx_abapgit_exception.