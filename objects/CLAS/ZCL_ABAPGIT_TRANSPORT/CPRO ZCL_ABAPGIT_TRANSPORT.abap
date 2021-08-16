  PROTECTED SECTION.

    CLASS-METHODS read_requests
      IMPORTING
        !it_trkorr         TYPE trwbo_request_headers
      RETURNING
        VALUE(rt_requests) TYPE trwbo_requests
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS find_top_package
      IMPORTING
        !it_tadir         TYPE zif_abapgit_definitions=>ty_tadir_tt
      RETURNING
        VALUE(rv_package) TYPE devclass
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS resolve
      IMPORTING
        !it_requests    TYPE trwbo_requests
      RETURNING
        VALUE(rt_tadir) TYPE zif_abapgit_definitions=>ty_tadir_tt
      RAISING
        zcx_abapgit_exception .