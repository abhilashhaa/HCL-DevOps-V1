  PROTECTED SECTION.

    CONSTANTS:
      BEGIN OF c_settings,
        name  TYPE string VALUE 'NAME',
        email TYPE string VALUE 'EMAIL',
      END OF c_settings .
    DATA mi_log TYPE REF TO zif_abapgit_log .

    METHODS build_comment
      IMPORTING
        !is_files         TYPE zif_abapgit_definitions=>ty_stage_files
      RETURNING
        VALUE(rv_comment) TYPE string .
    METHODS push_fixed
      IMPORTING
        !io_repo  TYPE REF TO zcl_abapgit_repo_online
        !iv_name  TYPE string
        !iv_email TYPE string
      RAISING
        zcx_abapgit_exception .