  PROTECTED SECTION.
    DATA mv_package TYPE devclass .

    METHODS create_variant
      IMPORTING
        !iv_variant       TYPE sci_chkv
      RETURNING
        VALUE(ro_variant) TYPE REF TO cl_ci_checkvariant
      RAISING
        zcx_abapgit_exception .
    METHODS cleanup
      IMPORTING
        !io_set TYPE REF TO cl_ci_objectset
      RAISING
        zcx_abapgit_exception .
    METHODS skip_object
      IMPORTING
        !is_obj        TYPE scir_objs
      RETURNING
        VALUE(rv_skip) TYPE abap_bool.