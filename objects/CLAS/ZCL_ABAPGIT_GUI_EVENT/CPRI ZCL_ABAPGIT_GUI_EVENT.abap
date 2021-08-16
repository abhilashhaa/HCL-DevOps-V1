  PRIVATE SECTION.
    DATA mo_query TYPE REF TO zcl_abapgit_string_map.
    DATA mo_query_upper_cased TYPE REF TO zcl_abapgit_string_map.

    METHODS fields_to_map
      IMPORTING
        it_fields            TYPE tihttpnvp
      RETURNING
        VALUE(ro_string_map) TYPE REF TO zcl_abapgit_string_map
      RAISING
        zcx_abapgit_exception.
