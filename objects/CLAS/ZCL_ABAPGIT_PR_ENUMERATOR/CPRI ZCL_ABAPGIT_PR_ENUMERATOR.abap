  PRIVATE SECTION.
    DATA mv_repo_url TYPE string.
    DATA mi_enum_provider TYPE REF TO zif_abapgit_pr_enum_provider.

    CLASS-METHODS create_provider
      IMPORTING
        iv_repo_url TYPE string
      RETURNING
        VALUE(ri_provider) TYPE REF TO zif_abapgit_pr_enum_provider
      RAISING
        zcx_abapgit_exception.
