  METHOD constructor.
    super->constructor( ).
    ms_control-page_title = 'Syntax Check'.
    mo_repo = io_repo.
    run_syntax_check( ).
  ENDMETHOD.