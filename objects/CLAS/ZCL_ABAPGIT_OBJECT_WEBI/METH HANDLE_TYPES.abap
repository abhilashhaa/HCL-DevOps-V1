  METHOD handle_types.

    DATA: lv_index TYPE i,
          li_soap  TYPE REF TO if_ws_md_soap_extension_type,
          li_struc TYPE REF TO if_ws_md_vif_struc_type,
          li_field TYPE REF TO if_ws_md_vif_field,
          li_table TYPE REF TO if_ws_md_vif_table_type,
          li_elem  TYPE REF TO if_ws_md_vif_elem_type.

    FIELD-SYMBOLS: <ls_elem>  LIKE LINE OF is_webi-pvepelemtype,
                   <ls_table> LIKE LINE OF is_webi-pveptabletype,
                   <ls_soap>  LIKE LINE OF is_webi-pveptypesoapext,
                   <ls_struc> LIKE LINE OF is_webi-pvepstrutype.


    LOOP AT is_webi-pvepelemtype ASSIGNING <ls_elem>.
      li_elem = mi_vi->create_type_as_elementary( <ls_elem>-typename ).
      li_elem->set_built_in_type( <ls_elem>-build_in_type ).
      li_elem->set_decimals( <ls_elem>-decimals ).
      li_elem->set_kind( <ls_elem>-kind ).
      li_elem->set_length( <ls_elem>-length ).
      li_elem->set_signed( <ls_elem>-signed ).
      li_elem->set_abaptype( <ls_elem>-abaptype ).

      IF li_elem->if_ws_md_vif_type~has_soap_extension_type( sews_c_vif_version-all ) = abap_false.
        READ TABLE is_webi-pveptypesoapext ASSIGNING <ls_soap>
          WITH KEY typename = <ls_elem>-typename.
        IF sy-subrc = 0.
          li_soap = li_elem->if_ws_md_vif_type~create_soap_extension_type( ).
          li_soap->set_namespace( <ls_soap>-namespace ).
        ENDIF.
      ENDIF.
    ENDLOOP.

    LOOP AT is_webi-pvepstrutype ASSIGNING <ls_struc>.
      lv_index = sy-tabix.

      li_struc = mi_vi->create_type_as_structure( <ls_struc>-typename ).

      IF li_struc->has_field( field_pos = <ls_struc>-fieldpos
          version = sews_c_vif_version-active ) = abap_true.
        CONTINUE.
      ENDIF.

      li_field = li_struc->create_field(
        field_name = <ls_struc>-fieldname
        fieldpos = <ls_struc>-fieldpos ).
      li_field->set_type( mi_vi->get_type( typename = <ls_struc>-typeref
                                           version  = sews_c_vif_version-inactive ) ).

      IF lv_index = 1
          AND li_struc->if_ws_md_vif_type~has_soap_extension_type(
          sews_c_vif_version-all ) = abap_false.
        READ TABLE is_webi-pveptypesoapext ASSIGNING <ls_soap>
          WITH KEY typename = <ls_struc>-typename.
        IF sy-subrc = 0.
          li_soap = li_struc->if_ws_md_vif_type~create_soap_extension_type( ).
          li_soap->set_namespace( <ls_soap>-namespace ).
        ENDIF.
      ENDIF.
    ENDLOOP.

    LOOP AT is_webi-pveptabletype ASSIGNING <ls_table>.
      li_table = mi_vi->create_type_as_table( <ls_table>-typename ).
      li_table->set_line_type( mi_vi->get_type( typename = <ls_table>-typeref
                                                version  = sews_c_vif_version-inactive ) ).

      IF li_table->if_ws_md_vif_type~has_soap_extension_type( sews_c_vif_version-all ) = abap_false.
        READ TABLE is_webi-pveptypesoapext ASSIGNING <ls_soap>
          WITH KEY typename = <ls_table>-typename.
        IF sy-subrc = 0.
          li_soap = li_table->if_ws_md_vif_type~create_soap_extension_type( ).
          li_soap->set_namespace( <ls_soap>-namespace ).
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.