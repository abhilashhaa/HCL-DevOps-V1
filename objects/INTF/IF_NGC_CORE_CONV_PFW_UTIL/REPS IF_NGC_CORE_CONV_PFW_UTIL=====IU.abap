INTERFACE if_ngc_core_conv_pfw_util
  PUBLIC.

  METHODS combine_seltabs
    IMPORTING
      it_named_seltabs      TYPE cl_shdb_pfw_seltab=>tt_named_seltab OPTIONAL
      it_named_flat         TYPE cl_shdb_pfw_seltab=>tt_named_flat OPTIONAL
      iv_client_field       TYPE string OPTIONAL
      iv_dbsys              TYPE dbsys-dbsys OPTIONAL
      iv_avoid_empty_clause TYPE abap_bool DEFAULT abap_true
      iv_table_alias        TYPE string OPTIONAL
        PREFERRED PARAMETER it_named_flat
    RETURNING
      VALUE(rv_where)       TYPE string.

ENDINTERFACE.