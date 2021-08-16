  METHOD dbcontent_decode.

    DATA lt_fields TYPE tihttpnvp.

    lt_fields = zcl_abapgit_html_action_utils=>parse_post_form_data(
      it_post_data = it_postdata
      iv_upper_cased = abap_true ).

    zcl_abapgit_html_action_utils=>get_field(
      EXPORTING
        iv_name = 'TYPE'
        it_field = lt_fields
      CHANGING
        cg_field = rs_content-type ).
    zcl_abapgit_html_action_utils=>get_field(
      EXPORTING
        iv_name = 'VALUE'
        it_field = lt_fields
      CHANGING
        cg_field = rs_content-value ).
    zcl_abapgit_html_action_utils=>get_field(
      EXPORTING
        iv_name = 'XMLDATA'
        it_field = lt_fields
      CHANGING
        cg_field = rs_content-data_str ).

    IF rs_content-data_str(1) <> '<' AND rs_content-data_str+1(1) = '<'. " Hmmm ???
      rs_content-data_str = rs_content-data_str+1.
    ENDIF.

  ENDMETHOD.