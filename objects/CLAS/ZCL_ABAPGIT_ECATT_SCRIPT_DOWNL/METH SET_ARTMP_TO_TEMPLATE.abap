  METHOD set_artmp_to_template.

    " Downport

    DATA: li_artmp_node   TYPE REF TO if_ixml_element,
          lv_rc           TYPE sy-subrc,
          lv_text         TYPE string,
          lv_rc_args_tmpl TYPE i,
          lv_errmsg       TYPE string.

    li_artmp_node = template_over_all->create_simple_element(
                      name   = 'ECET_ARTMP'
                      parent = root_node ).

    ecatt_extprog->get_args_tmpl(
      IMPORTING
        ex_xml_arg_tmpl = lv_text
        ex_rc           = lv_rc_args_tmpl
        ex_errmsg       = lv_errmsg ).

    IF li_artmp_node IS INITIAL OR lv_rc_args_tmpl > 0.
      me->raise_download_exception(
          textid        = cx_ecatt_apl_util=>download_processing
          previous      = ex_ecatt
          called_method = 'CL_APL_ECATT_SCRIPT_DOWNLOAD->SET_ARTMP_TO_TEMPLATE'
          free_text     = lv_errmsg ).
    ENDIF.

    lv_rc = li_artmp_node->set_value( value = lv_text ).
    IF lv_rc <> 0.
      me->raise_download_exception(
            textid        = cx_ecatt_apl_util=>download_processing
            previous      = ex_ecatt
            called_method = 'CL_APL_ECATT_SCRIPT_DOWNLOAD->SET_ARTMP_TO_TEMPLATE' ).
    ENDIF.

  ENDMETHOD.