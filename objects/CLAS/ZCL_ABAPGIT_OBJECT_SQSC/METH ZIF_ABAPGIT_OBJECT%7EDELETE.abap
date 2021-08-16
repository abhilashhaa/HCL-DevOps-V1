  METHOD zif_abapgit_object~delete.

    DATA: lx_error TYPE REF TO cx_root.

    TRY.
        CALL METHOD mo_proxy->('IF_DBPROC_PROXY_UI~DELETE')
          EXPORTING
            if_transport_req = mv_transport.

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise( iv_text     = lx_error->get_text( )
                                      ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.