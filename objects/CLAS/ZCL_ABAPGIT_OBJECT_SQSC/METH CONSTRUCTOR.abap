  METHOD constructor.

    FIELD-SYMBOLS: <lv_dbproxyname> TYPE ty_abap_name.

    super->constructor( is_item     = is_item
                        iv_language = iv_language ).

    TRY.
        CREATE OBJECT mo_proxy
          TYPE ('CL_DDIC_WB_DBPROC_PROXY').

        ASSIGN ('MO_PROXY->IF_DDIC_WB_DBPROC_PROXY~DBPROXYNAME')
            TO <lv_dbproxyname>.
        ASSERT sy-subrc = 0.

      CATCH cx_root.
        zcx_abapgit_exception=>raise( |SQSC not supported| ).
    ENDTRY.

    <lv_dbproxyname> = ms_item-obj_name.

    mv_transport = zcl_abapgit_default_transport=>get_instance(
                                               )->get(
                                               )-ordernum.

  ENDMETHOD.