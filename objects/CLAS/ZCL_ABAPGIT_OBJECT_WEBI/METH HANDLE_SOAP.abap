  METHOD handle_soap.

    DATA: li_soap TYPE REF TO if_ws_md_soap_ext_virtinfc,
          ls_soap LIKE LINE OF is_webi-pvepvisoapext.


    READ TABLE is_webi-pvepvisoapext INDEX 1 INTO ls_soap.
    ASSERT sy-subrc = 0.

    IF mi_vi->has_soap_extension_virtinfc( sews_c_vif_version-active ) = abap_true.
      RETURN.
    ENDIF.

    IF mi_vi->has_soap_extension_virtinfc( sews_c_vif_version-inactive ) = abap_true.
      li_soap = mi_vi->get_soap_extension_virtinfc( sews_c_vif_version-inactive ).
    ELSE.
      li_soap = mi_vi->create_soap_extension_virtinfc( ls_soap-soap_appl_uri ).
    ENDIF.

    li_soap->set_namespace( ls_soap-namespace ).

  ENDMETHOD.