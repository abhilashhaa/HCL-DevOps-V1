  METHOD zif_abapgit_object~serialize.

    DATA: ls_proxy TYPE ty_proxy,
          lx_error TYPE REF TO cx_root.

    TRY.
        CALL METHOD mo_proxy->('IF_DBPROC_PROXY_UI~READ_FROM_SOURCE')
          EXPORTING
            if_version        = 'A'
          IMPORTING
            es_header         = ls_proxy-header
            et_parameter      = ls_proxy-parameters
            et_parameter_type = ls_proxy-parameter_types.

        CALL METHOD mo_proxy->('IF_DBPROC_PROXY_UI~READ_DESCR')
          EXPORTING
            if_langu   = mv_language
            if_version = 'A'
          IMPORTING
            ef_descr   = ls_proxy-description.

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise( iv_text     = lx_error->get_text( )
                                      ix_previous = lx_error ).
    ENDTRY.

    io_xml->add( iv_name = 'SQSC'
                 ig_data = ls_proxy ).

  ENDMETHOD.