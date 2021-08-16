  PRIVATE SECTION.
    METHODS:
      clear_fields
        CHANGING
          cs_dynamic_cache TYPE any,

      clear_field
        IMPORTING
          iv_fieldname     TYPE csequence
        CHANGING
          cs_dynamic_cache TYPE any,

      fill_metadata_from_db
        CHANGING
          cs_dynamic_cache TYPE any
        RAISING
          zcx_abapgit_exception,

      get_transport_req_if_needed
        IMPORTING
          iv_package                  TYPE devclass
        RETURNING
          VALUE(rv_transport_request) TYPE trkorr
        RAISING
          zcx_abapgit_exception,

      get_wb_object_operator
        RETURNING
          VALUE(ri_wb_object_operator) TYPE REF TO object
        RAISING
          zcx_abapgit_exception.

    DATA:
      mr_dynamic_cache      TYPE REF TO data,
      mv_dynamic_cache_key  TYPE seu_objkey,
      mi_persistence        TYPE REF TO if_wb_object_persist,
      mi_wb_object_operator TYPE REF TO object.
