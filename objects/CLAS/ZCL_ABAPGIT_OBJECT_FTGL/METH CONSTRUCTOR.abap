  METHOD constructor.

    super->constructor(
      is_item     = is_item
      iv_language = iv_language ).

    mv_toggle_id = ms_item-obj_name.

    TRY.
        CREATE DATA mr_toggle TYPE ('FTGL_S_WB_FEATURE_TOGGLE').
      CATCH cx_root.
        zcx_abapgit_exception=>raise( |FTGL not supported in your NW release| ).
    ENDTRY.

  ENDMETHOD.