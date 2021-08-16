CLASS zcl_abapgit_proxy_config DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor,

      get_proxy_url
        IMPORTING
          iv_repo_url         TYPE csequence OPTIONAL
        RETURNING
          VALUE(rv_proxy_url) TYPE string,

      get_proxy_port
        IMPORTING
          iv_repo_url    TYPE csequence OPTIONAL
        RETURNING
          VALUE(rv_port) TYPE string,

      get_proxy_authentication
        IMPORTING
          iv_repo_url    TYPE csequence OPTIONAL
        RETURNING
          VALUE(rv_auth) TYPE abap_bool.
