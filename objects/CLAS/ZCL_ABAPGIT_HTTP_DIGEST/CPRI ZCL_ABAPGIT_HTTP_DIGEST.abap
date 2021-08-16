  PRIVATE SECTION.
    DATA: mv_ha1      TYPE string,
          mv_username TYPE string,
          mv_realm    TYPE string,
          mv_qop      TYPE string,
          mv_nonce    TYPE string.

    CLASS-DATA: gv_nc TYPE n LENGTH 8.

    CLASS-METHODS:
      md5
        IMPORTING
                  iv_data        TYPE string
        RETURNING
                  VALUE(rv_hash) TYPE string
        RAISING   zcx_abapgit_exception.

    METHODS:
      hash
        IMPORTING
                  iv_qop             TYPE string
                  iv_nonce           TYPE string
                  iv_uri             TYPE string
                  iv_method          TYPE string
                  iv_cnonse          TYPE string
        RETURNING
                  VALUE(rv_response) TYPE string
        RAISING   zcx_abapgit_exception,
      parse
        IMPORTING
          ii_client TYPE REF TO if_http_client.
