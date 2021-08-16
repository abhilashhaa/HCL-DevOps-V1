  METHOD has_unseen.
    rv_boolean = boolc( compare_versions(
      iv_a = mv_latest_version
      iv_b = mv_lastseen_version ) > 0 ).
  ENDMETHOD.