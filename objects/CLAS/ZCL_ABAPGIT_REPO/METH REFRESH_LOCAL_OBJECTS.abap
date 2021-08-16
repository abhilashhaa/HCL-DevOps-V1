  METHOD refresh_local_objects.

    mv_request_local_refresh = abap_true.
    get_files_local( ).

  ENDMETHOD.