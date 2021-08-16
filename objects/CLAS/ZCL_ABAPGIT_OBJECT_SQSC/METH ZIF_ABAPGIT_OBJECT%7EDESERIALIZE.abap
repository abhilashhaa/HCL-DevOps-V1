  METHOD zif_abapgit_object~deserialize.

    DATA: ls_proxy TYPE ty_proxy,
          lx_error TYPE REF TO cx_root.

    io_xml->read(
      EXPORTING
        iv_name = 'SQSC'
      CHANGING
        cg_data = ls_proxy ).

    IF zif_abapgit_object~exists( ) = abap_false.

      delete_interface_if_it_exists(
          iv_package   = iv_package
          iv_interface = ls_proxy-header-interface_pool ).

      CALL METHOD mo_proxy->('IF_DBPROC_PROXY_UI~CREATE')
        EXPORTING
          if_interface_pool = ls_proxy-header-interface_pool
          if_transport_req  = mv_transport
          if_package        = iv_package
          if_langu          = mv_language.

    ENDIF.

    TRY.
        CALL METHOD mo_proxy->('IF_DBPROC_PROXY_UI~WRITE_TO_SOURCE')
          EXPORTING
            if_transport_req  = mv_transport
            is_header         = ls_proxy-header
            it_parameter      = ls_proxy-parameters
            it_parameter_type = ls_proxy-parameter_types.

        CALL METHOD mo_proxy->('IF_DBPROC_PROXY_UI~WRITE_DESCR')
          EXPORTING
            if_langu = mv_language
            if_descr = ls_proxy-description.

        CALL METHOD mo_proxy->('IF_DBPROC_PROXY_UI~ACTIVATE').

        tadir_insert( iv_package ).

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise( iv_text     = lx_error->get_text( )
                                      ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.