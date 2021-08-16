  METHOD render_local_settings.

    DATA: lv_checked  TYPE string,
          ls_settings TYPE zif_abapgit_persistence=>ty_repo-local_settings.

    ls_settings = mo_repo->get_local_settings( ).

    ii_html->add( '<h2>Local Settings</h2>' ).
    ii_html->add( '<table class="settings">' ).

    ii_html->add( render_table_row(
      iv_name  = 'Display Name'
      iv_value = |<input name="display_name" type="text" size="30" value="{ ls_settings-display_name }">|
    ) ).

    CLEAR lv_checked.
    IF ls_settings-write_protected = abap_true.
      IF zcl_abapgit_factory=>get_environment( )->is_repo_object_changes_allowed( ) = abap_true.
        lv_checked = | checked|.
      ELSE.
        lv_checked = | checked disabled|.
      ENDIF.
    ENDIF.
    ii_html->add( render_table_row(
      iv_name  = 'Write Protected'
      iv_value = |<input name="write_protected" type="checkbox"{ lv_checked }>|
    ) ).

    CLEAR lv_checked.
    IF ls_settings-ignore_subpackages = abap_true.
      lv_checked = | checked|.
    ENDIF.
    ii_html->add( render_table_row(
      iv_name  = 'Ignore Subpackages'
      iv_value = |<input name="ignore_subpackages" type="checkbox"{ lv_checked }>|
    ) ).

    CLEAR lv_checked.
    IF ls_settings-only_local_objects = abap_true.
      lv_checked = | checked|.
    ENDIF.
    ii_html->add( render_table_row(
      iv_name  = 'Only Local Objects'
      iv_value = |<input name="only_local_objects" type="checkbox"{ lv_checked }>|
    ) ).

    ii_html->add( render_table_row(
      iv_name  = 'Code Inspector Check Variant'
      iv_value = |<input name="check_variant" type="text" size="30" value="{
        ls_settings-code_inspector_check_variant }">|
    ) ).

    CLEAR lv_checked.
    IF ls_settings-block_commit = abap_true.
      lv_checked = | checked|.
    ENDIF.
    ii_html->add( render_table_row(
      iv_name  = 'Block Commit If Code Inspection Has Errors'
      iv_value = |<input name="block_commit" type="checkbox"{ lv_checked }>|
    ) ).

    CLEAR lv_checked.
    IF ls_settings-serialize_master_lang_only = abap_true.
      lv_checked = | checked|.
    ENDIF.
    ii_html->add( render_table_row(
      iv_name  = 'Serialize Master Language Only'
      iv_value = |<input name="serialize_master_lang_only" type="checkbox"{ lv_checked }>|
    ) ).

    ii_html->add( '</table>' ).

  ENDMETHOD.