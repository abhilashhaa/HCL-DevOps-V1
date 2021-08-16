  METHOD has_updates.
    rv_boolean = boolc( compare_versions(
      iv_a = mv_latest_version
      iv_b = mv_current_version ) > 0 ).
  ENDMETHOD.