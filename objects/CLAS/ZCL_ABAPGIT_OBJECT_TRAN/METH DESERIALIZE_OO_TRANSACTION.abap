  METHOD deserialize_oo_transaction.

    " You should remember that we don't use batch input just for fun,
    " but because FM RPY_TRANSACTION_INSERT doesn't support OO transactions.

    DATA: ls_bcdata  TYPE bdcdata.


    CLEAR mt_bcdata.

    ls_bcdata-program  = 'SAPLSEUK'.
    ls_bcdata-dynpro   = '0390'.
    ls_bcdata-dynbegin = 'X'.
    APPEND ls_bcdata TO mt_bcdata.

    add_data( iv_fnam = 'TSTC-TCODE'
              iv_fval = is_tstc-tcode ).

    IF zif_abapgit_object~exists( ) = abap_true.

      add_data( iv_fnam = 'BDC_OKCODE'
                iv_fval = '=CHNG' ).

    ELSE.

      add_data( iv_fnam = 'BDC_OKCODE'
                iv_fval = '=ADD' ).

    ENDIF.

    ls_bcdata-program  = 'SAPLSEUK'.
    ls_bcdata-dynpro   = '0300'.
    ls_bcdata-dynbegin = 'X'.
    APPEND ls_bcdata TO mt_bcdata.

    add_data( iv_fnam     = 'TSTCT-TTEXT'
              iv_fval     = is_tstct-ttext ).

    add_data( iv_fnam     = 'RSSTCD-S_CLASS'
              iv_fval     = 'X' ).

    add_data( iv_fnam = 'BDC_OKCODE'
              iv_fval = '=ENTR' ).

    ls_bcdata-program  = 'SAPLSEUK'.
    ls_bcdata-dynpro   = '0360'.
    ls_bcdata-dynbegin = 'X'.
    APPEND ls_bcdata TO mt_bcdata.

    add_data( iv_fnam     = 'RSSTCD-S_TRFRAME'
              iv_fval     = is_rsstcd-s_trframe ).

    add_data( iv_fnam     = 'RSSTCD-S_UPDTASK'
              iv_fval     = is_rsstcd-s_updtask ).

    add_data( iv_fnam = 'BDC_OKCODE'
              iv_fval = '=TR_FRAMEWORK' ).

    ls_bcdata-program  = 'SAPLSEUK'.
    ls_bcdata-dynpro   = '0360'.
    ls_bcdata-dynbegin = 'X'.
    APPEND ls_bcdata TO mt_bcdata.

    add_data( iv_fnam     = 'RSSTCD-CLASSNAME'
              iv_fval     = is_rsstcd-classname ).

    add_data( iv_fnam     = 'RSSTCD-METHOD'
              iv_fval     = is_rsstcd-method ).

    IF is_rsstcd-s_local IS NOT INITIAL.
      add_data( iv_fnam     = 'RSSTCD-S_LOCAL'
                iv_fval     = is_rsstcd-s_local ).
    ENDIF.

    IF is_rsstcd-s_updlok IS NOT INITIAL.
      add_data( iv_fnam     = 'RSSTCD-S_UPDLOK'
                iv_fval     = is_rsstcd-s_updlok ).
    ENDIF.

    add_data( iv_fnam     = 'TSTC-PGMNA'
              iv_fval     = is_tstc-pgmna ).

    IF is_tstcc-s_webgui = '2'.

      add_data( iv_fnam     = 'G_IAC_EWT'
                iv_fval     = abap_true ).

      add_data( iv_fnam = 'BDC_OKCODE'
                iv_fval = 'MAKE_PROFI' ).

      ls_bcdata-program  = 'SAPLSEUK'.
      ls_bcdata-dynpro   = '0360'.
      ls_bcdata-dynbegin = 'X'.
      APPEND ls_bcdata TO mt_bcdata.

    ELSEIF is_tstcc-s_webgui IS NOT INITIAL.

      add_data( iv_fnam     = 'TSTCC-S_WEBGUI'
                iv_fval     = is_tstcc-s_webgui ).

    ENDIF.

    IF is_tstcc-s_pervas IS NOT INITIAL.
      add_data( iv_fnam     = 'TSTCC-S_PERVAS'
                iv_fval     = is_tstcc-s_pervas ).
    ENDIF.

    IF is_tstcc-s_service IS NOT INITIAL.
      add_data( iv_fnam     = 'TSTCC-S_SERVICE'
                iv_fval     = is_tstcc-s_service ).
    ENDIF.

    IF is_tstcc-s_platin IS NOT INITIAL.
      add_data( iv_fnam     = 'TSTCC-S_PLATIN'
                iv_fval     = is_tstcc-s_platin ).
    ENDIF.

    IF is_tstcc-s_win32 IS NOT INITIAL.
      add_data( iv_fnam     = 'TSTCC-S_WIN32'
                iv_fval     = is_tstcc-s_win32 ).
    ENDIF.

    add_data( iv_fnam = 'BDC_OKCODE'
              iv_fval = '=WB_SAVE' ).

    ls_bcdata-program  = 'SAPLSTRD'.
    ls_bcdata-dynpro   = '0100'.
    ls_bcdata-dynbegin = 'X'.
    APPEND ls_bcdata TO mt_bcdata.

    add_data( iv_fnam     = 'KO007-L_DEVCLASS'
              iv_fval     = iv_package ).

    add_data( iv_fnam = 'BDC_OKCODE'
              iv_fval = '=ADD' ).

    ls_bcdata-program  = 'BDC_OKCODE'.
    ls_bcdata-dynpro   = '0360'.
    ls_bcdata-dynbegin = 'X'.
    APPEND ls_bcdata TO mt_bcdata.

    add_data( iv_fnam = 'BDC_OKCODE'
              iv_fval = '=WB_BACK' ).

    ls_bcdata-program  = 'BDC_OKCODE'.
    ls_bcdata-dynpro   = '0360'.
    ls_bcdata-dynbegin = 'X'.
    APPEND ls_bcdata TO mt_bcdata.

    add_data( iv_fnam = 'BDC_OKCODE'
              iv_fval = '=WB_BACK' ).

    call_se93( ).

  ENDMETHOD.