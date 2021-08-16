  PRIVATE SECTION.

    DATA mi_raw TYPE REF TO if_ixml_element .
    DATA ms_i18n_params TYPE zif_abapgit_xml_output~ty_i18n_params .

    METHODS build_asx_node
      RETURNING
        VALUE(ri_element) TYPE REF TO if_ixml_element .