  METHOD constructor.
    super->constructor( ).
    ms_control-page_title = 'Branch Overview'.
    mo_repo = io_repo.
    refresh( ).
  ENDMETHOD.