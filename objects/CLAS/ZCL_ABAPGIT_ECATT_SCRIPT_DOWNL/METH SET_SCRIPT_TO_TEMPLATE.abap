  METHOD set_script_to_template.

    " Downport

    DATA:
      lt_text    TYPE etxml_line_tabtype,
      li_element TYPE REF TO if_ixml_element,
      lv_rc      TYPE sy-subrc.

    ecatt_script->get_script_text( CHANGING scripttext = lt_text ).

    mi_script_node = template_over_all->create_simple_element(
                        name = 'SCRIPT'
                        parent = root_node ).

    IF mi_script_node IS INITIAL.
      me->raise_download_exception(
            textid        = cx_ecatt_apl_util=>download_processing
            previous      = ex_ecatt
            called_method = 'CL_APL_ECATT_SCRIPT_DOWNLOAD->SET_SCRIPT_TO_TEMPLATE' ).
    ENDIF.

    CALL FUNCTION 'SDIXML_DATA_TO_DOM'
      EXPORTING
        name         = 'ETXML_LINE_TABTYPE'
        dataobject   = lt_text
      IMPORTING
        data_as_dom  = li_element
      CHANGING
        document     = template_over_all
      EXCEPTIONS
        illegal_name = 1
        OTHERS       = 2.
    IF sy-subrc <> 0.
      me->raise_download_exception(
            textid        = cx_ecatt_apl_util=>download_processing
            previous      = ex_ecatt
            called_method = 'CL_APL_ECATT_SCRIPT_DOWNLOAD->SET_SCRIPT_TO_TEMPLATE' ).

    ENDIF.

    lv_rc = mi_script_node->append_child( li_element ).
    IF lv_rc <> 0.
      me->raise_download_exception(
            textid        = cx_ecatt_apl_util=>download_processing
            previous      = ex_ecatt
            called_method = 'CL_APL_ECATT_SCRIPT_DOWNLOAD->SET_SCRIPT_TO_TEMPLATE' ).
    ENDIF.

  ENDMETHOD.