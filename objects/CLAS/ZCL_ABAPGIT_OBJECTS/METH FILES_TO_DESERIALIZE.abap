  METHOD files_to_deserialize.

    rt_results = adjust_namespaces(
                   prioritize_deser(
                     filter_files_to_deserialize(
                       it_results = zcl_abapgit_file_status=>status( io_repo )
                       ii_log     = ii_log ) ) ).

  ENDMETHOD.