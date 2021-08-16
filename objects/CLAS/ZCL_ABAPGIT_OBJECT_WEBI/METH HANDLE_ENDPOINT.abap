  METHOD handle_endpoint.

    DATA: ls_endpoint LIKE LINE OF is_webi-pvependpoint,
          li_endpoint TYPE REF TO if_ws_md_vif_endpoint_ref.

    FIELD-SYMBOLS: <ls_function> LIKE LINE OF is_webi-pvepfunction.


    READ TABLE is_webi-pvependpoint INDEX 1 INTO ls_endpoint.
    ASSERT sy-subrc = 0.

    IF mi_vi->has_endpoint_reference( sews_c_vif_version-all ) = abap_true.
      RETURN.
    ENDIF.

    li_endpoint = mi_vi->create_endpoint_reference(
      endpoint_type          = ls_endpoint-endpointtype
      service_def_startpoint = ls_endpoint-def_start_pt
      auto_generated         = ls_endpoint-auto_generated
      i_is_srvv              = ls_endpoint-is_srvv ).

    IF ls_endpoint-endpointtype = 'BAPI'.
* it looks like some special handling is needed when calling
* set_data, and looking at the cluster data LS_ENDPOINT-CLUSTD
      zcx_abapgit_exception=>raise( 'todo, WEBI BAPI' ).
    ENDIF.

* field ls_endpoint-endpointname does not exist in 702
    READ TABLE is_webi-pvepfunction INDEX 1 ASSIGNING <ls_function>.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |WEBI { ms_item-obj_name }: couldn't detect endpoint name| ).
    ENDIF.

    li_endpoint->set_data(
      data_version = '1'
      data         = <ls_function>-function ).

  ENDMETHOD.