  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_info,
        repo_json TYPE REF TO zif_abapgit_ajson_reader,
        pulls     TYPE zif_abapgit_pr_enum_provider=>tty_pulls,
      END OF ty_info.

    DATA mi_http_agent TYPE REF TO zif_abapgit_http_agent.
    DATA mv_repo_url TYPE string.

    METHODS fetch_repo_by_url
      IMPORTING
        iv_repo_url    TYPE string
      RETURNING
        VALUE(rs_info) TYPE ty_info
      RAISING
        zcx_abapgit_exception.

    METHODS convert_list
      IMPORTING
        ii_json         TYPE REF TO zif_abapgit_ajson_reader
      RETURNING
        VALUE(rt_pulls) TYPE zif_abapgit_pr_enum_provider=>tty_pulls.

    METHODS clean_url
      IMPORTING
        iv_url        TYPE string
      RETURNING
        VALUE(rv_url) TYPE string.
