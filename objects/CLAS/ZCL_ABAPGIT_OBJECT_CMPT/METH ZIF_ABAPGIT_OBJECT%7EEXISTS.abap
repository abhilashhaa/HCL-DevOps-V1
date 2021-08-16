  METHOD zif_abapgit_object~exists.

    TRY.
        CALL METHOD ('CL_CMP_TEMPLATE')=>('S_TEMPLATE_EXISTS')
          EXPORTING
            i_name       = mv_name
            i_version    = 'A'
          RECEIVING
            r_flg_exists = rv_bool.

      CATCH cx_root.
        zcx_abapgit_exception=>raise( 'CMPT not supported' ).
    ENDTRY.

  ENDMETHOD.