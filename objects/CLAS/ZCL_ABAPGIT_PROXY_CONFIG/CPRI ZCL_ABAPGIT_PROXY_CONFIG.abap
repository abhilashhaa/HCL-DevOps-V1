  PRIVATE SECTION.
    DATA: mo_settings TYPE REF TO zcl_abapgit_settings,
          mi_exit     TYPE REF TO zif_abapgit_exit.

    METHODS:
      bypass_proxy
        IMPORTING
          iv_repo_url            TYPE csequence OPTIONAL
        RETURNING
          VALUE(rv_bypass_proxy) TYPE abap_bool.
