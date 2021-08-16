  PRIVATE SECTION.
    METHODS:
      clear_fields
        CHANGING
          cs_logical_db_schema TYPE any,

      clear_field
        IMPORTING
          iv_fieldname         TYPE csequence
        CHANGING
          cs_logical_db_schema TYPE any,

      fill_metadata_from_db
        CHANGING
          cs_logical_db_schema TYPE any
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
      mr_logical_db_schema     TYPE REF TO data,
      mv_logical_db_schema_key TYPE seu_objkey,
      mi_persistence           TYPE REF TO if_wb_object_persist,
      mi_wb_object_operator    TYPE REF TO object.
