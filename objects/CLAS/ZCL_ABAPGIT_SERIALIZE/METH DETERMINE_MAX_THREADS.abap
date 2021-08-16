  METHOD determine_max_threads.

    IF iv_force_sequential = abap_true.
      rv_threads = 1.
      RETURN.
    ENDIF.

    IF gv_max_threads >= 1.
* SPBT_INITIALIZE gives error PBT_ENV_ALREADY_INITIALIZED if called
* multiple times in same session
      rv_threads = gv_max_threads.
      RETURN.
    ENDIF.

    CALL FUNCTION 'FUNCTION_EXISTS'
      EXPORTING
        funcname           = 'Z_ABAPGIT_SERIALIZE_PARALLEL'
      EXCEPTIONS
        function_not_exist = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
      gv_max_threads = 1.
    ELSE.
* todo, add possibility to set group name in user exit
      CALL FUNCTION 'SPBT_INITIALIZE'
        EXPORTING
          group_name                     = mv_group
        IMPORTING
          free_pbt_wps                   = gv_max_threads
        EXCEPTIONS
          invalid_group_name             = 1
          internal_error                 = 2
          pbt_env_already_initialized    = 3
          currently_no_resources_avail   = 4
          no_pbt_resources_found         = 5
          cant_init_different_pbt_groups = 6
          OTHERS                         = 7.
      IF sy-subrc <> 0.
*   fallback to running sequentially. If SPBT_INITIALIZE fails, check transactions
*   RZ12, SM50, SM21, SARFC
        gv_max_threads = 1.
      ENDIF.
    ENDIF.

    IF gv_max_threads > 1.
      gv_max_threads = gv_max_threads - 1.
    ENDIF.

    ASSERT gv_max_threads >= 1.

    IF gv_max_threads > 32.
* https://en.wikipedia.org/wiki/Amdahl%27s_law
      gv_max_threads = 32.
    ENDIF.

    rv_threads = gv_max_threads.

  ENDMETHOD.