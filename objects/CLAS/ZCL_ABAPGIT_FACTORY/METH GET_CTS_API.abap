  METHOD get_cts_api.
    IF gi_cts_api IS NOT BOUND.
      CREATE OBJECT gi_cts_api TYPE zcl_abapgit_cts_api.
    ENDIF.

    ri_cts_api = gi_cts_api.
  ENDMETHOD.