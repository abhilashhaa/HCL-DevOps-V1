  PRIVATE SECTION.

    DATA mv_skip_testclass TYPE abap_bool .

    METHODS calculate_skip_testclass
      IMPORTING
        !it_source               TYPE zif_abapgit_definitions=>ty_string_tt
      RETURNING
        VALUE(rv_skip_testclass) TYPE abap_bool .
    METHODS serialize_abap_old
      IMPORTING
        !is_clskey       TYPE seoclskey
      RETURNING
        VALUE(rt_source) TYPE zif_abapgit_definitions=>ty_string_tt
      RAISING
        zcx_abapgit_exception .
    METHODS serialize_abap_new
      IMPORTING
        !is_clskey       TYPE seoclskey
      RETURNING
        VALUE(rt_source) TYPE zif_abapgit_definitions=>ty_string_tt
      RAISING
        zcx_abapgit_exception
        cx_sy_dyn_call_error .
    METHODS remove_signatures
      CHANGING
        !ct_source TYPE zif_abapgit_definitions=>ty_string_tt .
    METHODS read_include
      IMPORTING
        !is_clskey       TYPE seoclskey
        !iv_type         TYPE seop_include_ext_app
      RETURNING
        VALUE(rt_source) TYPE seop_source_string .
    METHODS reduce
      CHANGING
        !ct_source TYPE zif_abapgit_definitions=>ty_string_tt .