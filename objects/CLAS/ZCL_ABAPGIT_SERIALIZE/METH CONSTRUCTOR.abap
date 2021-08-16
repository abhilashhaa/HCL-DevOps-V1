  METHOD constructor.

    DATA lo_settings TYPE REF TO zcl_abapgit_settings.

    lo_settings = zcl_abapgit_persist_settings=>get_instance( )->read( ).

    IF zcl_abapgit_factory=>get_environment( )->is_merged( ) = abap_true
        OR lo_settings->get_parallel_proc_disabled( ) = abap_true.
      gv_max_threads = 1.
    ENDIF.

    mv_group = 'parallel_generators'.
    mv_serialize_master_lang_only = iv_serialize_master_lang_only.

  ENDMETHOD.