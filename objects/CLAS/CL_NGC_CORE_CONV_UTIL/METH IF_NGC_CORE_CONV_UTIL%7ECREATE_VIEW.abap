  METHOD if_ngc_core_conv_util~create_view.

    DATA:
      ls_cds_view    TYPE ddddlsrcv,
      lr_ddl_handler TYPE REF TO if_dd_ddl_handler.

    " Define CDS view.
    ls_cds_view-ddlname    = iv_view_name && `_DDL`.
    ls_cds_view-ddlanguage = 'E'.
    ls_cds_view-ddtext     = `Temporary helper view for ` && iv_app_name ##NO_TEXT.
    ls_cds_view-source     =
      `@AbapCatalog.sqlViewName: '` && iv_view_name && `' ` && cl_abap_char_utilities=>newline &&
      `@AccessControl.authorizationCheck: #NOT_REQUIRED ` && cl_abap_char_utilities=>newline ##NO_TEXT.

    " Allow client-independent (cross-client) CDS Views
    IF iv_client_dependent = abap_false.
      ls_cds_view-source =
        ls_cds_view-source &&
        `@ClientDependent: false ` && cl_abap_char_utilities=>newline ##NO_TEXT.
    ENDIF.

    ls_cds_view-source =
      ls_cds_view-source &&
      `define view ` && ls_cds_view-ddlname && ` as ` && cl_abap_char_utilities=>newline &&
      iv_view_source ##NO_TEXT.

    " Register as local object.
    cl_cfd_transport_adapter=>get_instance( )->handle_transport(
      iv_logical_transport_object   = 'DDLS'
      iv_object_name                = ls_cds_view-ddlname
      iv_package                    = '$TMP'
      iv_generation_flag            = abap_true
      iv_standard_editor_protection = abap_true
    ).

    " Save CDS view.
    lr_ddl_handler = cl_dd_ddl_handler_factory=>create( ).
    lr_ddl_handler->save(
      name         = ls_cds_view-ddlname
      put_state    = 'N'
      ddddlsrcv_wa = ls_cds_view
    ).

    " Activate CDS view.
    lr_ddl_handler->activate( ls_cds_view-ddlname ).

  ENDMETHOD.