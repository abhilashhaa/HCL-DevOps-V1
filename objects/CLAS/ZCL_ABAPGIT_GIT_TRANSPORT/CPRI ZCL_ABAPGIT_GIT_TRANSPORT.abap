  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF c_service,
        receive TYPE string VALUE 'receive',                "#EC NOTEXT
        upload  TYPE string VALUE 'upload',                 "#EC NOTEXT
      END OF c_service .
    CONSTANTS:
      BEGIN OF c_smart_response_check,
        BEGIN OF get_refs,
          content_regex TYPE string VALUE '^[0-9a-f]{4}#',
          content_type  TYPE string VALUE 'application/x-git-<service>-pack-advertisement',
        END OF get_refs,
      END OF c_smart_response_check .

    CLASS-METHODS branch_list
      IMPORTING
        !iv_url         TYPE string
        !iv_service     TYPE string
      EXPORTING
        !eo_client      TYPE REF TO zcl_abapgit_http_client
        !eo_branch_list TYPE REF TO zcl_abapgit_git_branch_list
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS find_branch
      IMPORTING
        !iv_url         TYPE string
        !iv_service     TYPE string
        !iv_branch_name TYPE string
      EXPORTING
        !eo_client      TYPE REF TO zcl_abapgit_http_client
        !ev_branch      TYPE zif_abapgit_definitions=>ty_sha1
        !eo_branch_list TYPE REF TO zcl_abapgit_git_branch_list
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS parse
      EXPORTING
        !ev_pack TYPE xstring
      CHANGING
        !cv_data TYPE xstring
      RAISING
        zcx_abapgit_exception .