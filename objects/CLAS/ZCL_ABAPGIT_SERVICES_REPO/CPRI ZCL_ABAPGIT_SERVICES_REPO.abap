  PRIVATE SECTION.

    CLASS-METHODS popup_overwrite
      CHANGING
        !ct_overwrite TYPE zif_abapgit_definitions=>ty_overwrite_tt
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS popup_package_overwrite
      CHANGING
        !ct_overwrite TYPE zif_abapgit_definitions=>ty_overwrite_tt
      RAISING
        zcx_abapgit_exception.