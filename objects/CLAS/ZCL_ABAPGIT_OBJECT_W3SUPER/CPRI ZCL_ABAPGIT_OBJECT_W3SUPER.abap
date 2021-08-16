  PRIVATE SECTION.

    DATA ms_key TYPE wwwdatatab.

    METHODS get_ext
      IMPORTING it_params     TYPE ty_wwwparams_tt
      RETURNING VALUE(rv_ext) TYPE string
      RAISING   zcx_abapgit_exception.

    METHODS normalize_params
      IMPORTING iv_size   TYPE i
      CHANGING  ct_params TYPE ty_wwwparams_tt  " Param table to patch
      RAISING   zcx_abapgit_exception.

    METHODS strip_params
      CHANGING ct_params TYPE ty_wwwparams_tt
      RAISING  zcx_abapgit_exception.

    METHODS find_param
      IMPORTING it_params       TYPE ty_wwwparams_tt
                iv_name         TYPE w3_name
      RETURNING VALUE(rv_value) TYPE string
      RAISING   zcx_abapgit_exception.
