  METHOD constructor.
    super->constructor( ).
    mo_repo = io_repo.
    mo_stage = io_stage.
    ms_control-page_title = 'Code Inspector'.
    determine_check_variant( ).
    run_code_inspector( ).
  ENDMETHOD.