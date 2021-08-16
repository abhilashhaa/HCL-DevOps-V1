  METHOD get_files_remote.
    fetch_remote( ).
    rt_files = super->get_files_remote( ).
  ENDMETHOD.