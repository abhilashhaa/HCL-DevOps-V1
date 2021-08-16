  PRIVATE SECTION.
    DATA mv_skip_test_classes TYPE abap_bool.

    METHODS deserialize_abap_source_old
      IMPORTING is_clskey TYPE seoclskey
                it_source TYPE zif_abapgit_definitions=>ty_string_tt
      RAISING   zcx_abapgit_exception.

    METHODS deserialize_abap_source_new
      IMPORTING is_clskey TYPE seoclskey
                it_source TYPE zif_abapgit_definitions=>ty_string_tt
      RAISING   zcx_abapgit_exception
                cx_sy_dyn_call_error.