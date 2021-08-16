  METHOD is_stage_allowed.

    rv_is_stage_allowed = boolc( NOT ( mo_repo->get_local_settings( )-block_commit = abap_true
                                           AND has_inspection_errors( ) = abap_true ) ).

  ENDMETHOD.