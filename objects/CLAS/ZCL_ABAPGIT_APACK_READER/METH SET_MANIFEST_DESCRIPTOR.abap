  METHOD set_manifest_descriptor.
    mv_is_cached = abap_true.
    ms_cached_descriptor = is_manifest_descriptor.
    format_version( ).
  ENDMETHOD.