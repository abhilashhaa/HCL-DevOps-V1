  METHOD apply_merged_content.

    DATA:
      BEGIN OF ls_filedata,
        merge_content TYPE string,
      END OF ls_filedata,
      lt_fields           TYPE tihttpnvp,
      lv_new_file_content TYPE xstring.

    FIELD-SYMBOLS:
      <ls_conflict>      TYPE zif_abapgit_definitions=>ty_merge_conflict.

    lt_fields = zcl_abapgit_html_action_utils=>parse_post_form_data(
      it_post_data = it_postdata
      iv_upper_cased = abap_true ).

    zcl_abapgit_html_action_utils=>get_field(
      EXPORTING
        iv_name = 'MERGE_CONTENT'
        it_field = lt_fields
      CHANGING
        cg_field = ls_filedata ).

    REPLACE ALL OCCURRENCES
      OF zif_abapgit_definitions=>c_crlf IN ls_filedata-merge_content WITH zif_abapgit_definitions=>c_newline.

    lv_new_file_content = zcl_abapgit_convert=>string_to_xstring_utf8( ls_filedata-merge_content ).

    READ TABLE mt_conflicts ASSIGNING <ls_conflict> INDEX mv_current_conflict_index.
    <ls_conflict>-result_sha1 = zcl_abapgit_hash=>sha1(
      iv_type = zif_abapgit_definitions=>c_type-blob
      iv_data = lv_new_file_content ).
    <ls_conflict>-result_data = lv_new_file_content.
    mo_merge->resolve_conflict( <ls_conflict> ).

  ENDMETHOD.