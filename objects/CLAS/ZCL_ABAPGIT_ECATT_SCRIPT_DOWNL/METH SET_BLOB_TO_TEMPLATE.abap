  METHOD set_blob_to_template.

    " Downport

    DATA: li_blob_node TYPE REF TO if_ixml_element,
          lv_rc        TYPE sy-subrc,
          lv_text      TYPE string.

    li_blob_node = template_over_all->create_simple_element(
                  name   = 'ECET_BLOBS'
                  parent = root_node ).

    IF li_blob_node IS INITIAL.
      me->raise_download_exception(
            textid        = cx_ecatt_apl_util=>download_processing
            previous      = ex_ecatt
            called_method = 'CL_APL_ECATT_SCRIPT_DOWNLOAD->SET_BLOB_TO_TEMPLATE' ).
    ENDIF.

    ecatt_extprog->get_blob(
      EXPORTING
        im_whole_data = 1
      IMPORTING
        ex_xml_blob   = lv_text ).

    lv_rc = li_blob_node->set_value( value = lv_text ).
    IF lv_rc <> 0.
      me->raise_download_exception(
            textid        = cx_ecatt_apl_util=>download_processing
            previous      = ex_ecatt
            called_method = 'CL_APL_ECATT_SCRIPT_DOWNLOAD->SET_BLOB_TO_TEMPLATE' ).
    ENDIF.

  ENDMETHOD.