  METHOD parse_commit_request.

    DATA lt_fields TYPE tihttpnvp.

    FIELD-SYMBOLS <lv_body> TYPE string.

    CLEAR eg_fields.

    lt_fields = zcl_abapgit_html_action_utils=>parse_post_form_data(
      it_post_data = it_postdata
      iv_upper_cased = abap_true ).

    zcl_abapgit_html_action_utils=>get_field(
      EXPORTING
        iv_name = 'COMMITTER_NAME'
        it_field = lt_fields
      CHANGING
        cg_field = eg_fields ).
    zcl_abapgit_html_action_utils=>get_field(
      EXPORTING
        iv_name = 'COMMITTER_EMAIL'
        it_field = lt_fields
      CHANGING
        cg_field = eg_fields ).
    zcl_abapgit_html_action_utils=>get_field(
      EXPORTING
        iv_name = 'AUTHOR_NAME'
        it_field = lt_fields
      CHANGING
        cg_field = eg_fields ).
    zcl_abapgit_html_action_utils=>get_field(
      EXPORTING
        iv_name = 'AUTHOR_EMAIL'
        it_field = lt_fields
      CHANGING
      cg_field = eg_fields ).
    zcl_abapgit_html_action_utils=>get_field(
      EXPORTING
        iv_name = 'COMMENT'
        it_field = lt_fields
      CHANGING
      cg_field = eg_fields ).
    zcl_abapgit_html_action_utils=>get_field(
      EXPORTING
        iv_name = 'BODY'
        it_field = lt_fields
      CHANGING
        cg_field = eg_fields ).

    ASSIGN COMPONENT 'BODY' OF STRUCTURE eg_fields TO <lv_body>.
    ASSERT <lv_body> IS ASSIGNED.
    REPLACE ALL OCCURRENCES OF zif_abapgit_definitions=>c_crlf IN <lv_body> WITH zif_abapgit_definitions=>c_newline.

  ENDMETHOD.