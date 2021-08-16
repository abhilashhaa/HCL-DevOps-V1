  METHOD constructor.

    super->constructor( ).

    mv_key = iv_key.
    ms_control-page_title = 'Background'.
    ms_control-page_menu  = build_menu( ).

  ENDMETHOD.