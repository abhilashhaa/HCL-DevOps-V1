  METHOD get_environment.
    IF gi_environment IS NOT BOUND.
      CREATE OBJECT gi_environment TYPE zcl_abapgit_environment.
    ENDIF.
    ri_environment = gi_environment.
  ENDMETHOD.