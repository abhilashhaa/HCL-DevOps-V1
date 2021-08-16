  METHOD if_ngc_core_conv_util~delete_view.

    DATA:
      ls_cds_view    TYPE ddddlsrcv,
      lr_ddl_handler TYPE REF TO if_dd_ddl_handler.

    ls_cds_view-ddlname = iv_view_name && `_DDL`.

    " Drop CDS view.
    lr_ddl_handler = cl_dd_ddl_handler_factory=>create( ).
    lr_ddl_handler->delete( ls_cds_view-ddlname ).

    " Delete the local object.
    DATA(lv_remove_directory_entry) = cl_cfd_transport_adapter=>get_instance( )->handle_deletion(
      iv_logical_transport_object   = 'DDLS'
      iv_object_name                = ls_cds_view-ddlname
    ).

    IF lv_remove_directory_entry = abap_true.
      cl_cfd_transport_adapter=>get_instance( )->remove_from_object_directory(
        iv_logical_transport_object = 'DDLS'
        iv_object_name              = ls_cds_view-ddlname
      ).
    ENDIF.

  ENDMETHOD.