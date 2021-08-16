  PRIVATE SECTION.

    DATA mo_global_headers TYPE REF TO zcl_abapgit_string_map.

    CLASS-METHODS attach_payload
      IMPORTING
        ii_request TYPE REF TO if_http_request
        iv_payload TYPE any
      RAISING
        zcx_abapgit_exception.
