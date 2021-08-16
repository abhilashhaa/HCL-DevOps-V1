  METHOD validate_and_unprettify_xml.

    rv_xml = zcl_abapgit_xml_pretty=>print(
      iv_xml           = iv_xml
      iv_unpretty      = abap_true
      iv_ignore_errors = abap_false ).

  ENDMETHOD.