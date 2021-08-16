  METHOD render_table_body.

    CONSTANTS: lc_separator TYPE string VALUE `<span class="separator">|</span>`.

    DATA:
      lv_type_icon         TYPE string,
      lv_favorite_icon     TYPE string,
      lv_favorite_class    TYPE string,
      lv_package_jump_data TYPE string,
      lv_package_obj_name  TYPE sobj_name,
      lv_stage_link        TYPE string,
      lv_patch_link        TYPE string,
      lv_zip_import_link   TYPE string,
      lv_zip_export_link   TYPE string,
      lv_check_link        TYPE string,
      lv_settings_link     TYPE string,
      lv_branch_html       TYPE string.

    FIELD-SYMBOLS: <ls_overview> LIKE LINE OF it_overview.

    ii_html->add( '<tbody>' ).

    LOOP AT it_overview ASSIGNING <ls_overview>.

      IF <ls_overview>-type = abap_true.
        lv_type_icon = 'plug/darkgrey'.
      ELSE.
        lv_type_icon = 'cloud-upload-alt/darkgrey'.
      ENDIF.

      IF <ls_overview>-favorite = abap_true.
        lv_favorite_icon = 'star/blue'.
        lv_favorite_class = 'favorite'.
      ELSE.
        lv_favorite_icon = 'star/grey'.
        lv_favorite_class = ''.
      ENDIF.

      ii_html->add( |<tr class="repo { lv_favorite_class }">| ).
      ii_html->add( |<td class="wmin">| ).
      ii_html->add_a( iv_act = |{ zif_abapgit_definitions=>c_action-repo_toggle_fav }?key={ <ls_overview>-key }|
                      iv_txt = ii_html->icon( iv_name  = lv_favorite_icon
                                              iv_class = 'pad-sides'
                                              iv_hint  = 'Click to toggle favorite' ) ).
      ii_html->add( |</td>| ).
      ii_html->add( |<td class="wmin">{ ii_html->icon( lv_type_icon ) }</td>| ).

      ii_html->add( |<td>{ ii_html->a( iv_txt = <ls_overview>-name
                                       iv_act = |{ c_action-select }?key={ <ls_overview>-key }| ) }</td>| ).

      IF <ls_overview>-type = abap_false.
        ii_html->add( |<td>{ ii_html->a( iv_txt = <ls_overview>-url
                                         iv_act = |{ zif_abapgit_definitions=>c_action-url }?url=|
                                               && |{ <ls_overview>-url }| ) }</td>| ).
      ELSE.
        ii_html->add( |<td></td>| ).
      ENDIF.

      lv_package_obj_name = <ls_overview>-package.
      lv_package_jump_data = zcl_abapgit_html_action_utils=>jump_encode(
        iv_obj_type = 'DEVC'
        iv_obj_name = lv_package_obj_name ).

      ii_html->add( |<td>{ ii_html->a(
          iv_txt = <ls_overview>-package
          iv_act = |{ zif_abapgit_definitions=>c_action-jump }?{ lv_package_jump_data }| ) }</td>| ).

      IF <ls_overview>-branch IS INITIAL.
        ii_html->add( |<td>&nbsp;</td>| ).
      ELSE.
        lv_branch_html = `<span class="branch branch_branch">`
          && `<i title="Current branch" class="icon icon-code-branch grey70"></i>`
          && <ls_overview>-branch
          && `</span>`.

        ii_html->add( |<td>{ ii_html->a(
          iv_txt = lv_branch_html
          iv_act = |{ zif_abapgit_definitions=>c_action-git_branch_switch }?key={ <ls_overview>-key }| ) }</td>| ).
      ENDIF.

      ii_html->add( |<td class="ro-detail">{ <ls_overview>-deserialized_by }</td>| ).
      ii_html->add( |<td class="ro-detail">{ <ls_overview>-deserialized_at }</td>| ).
      ii_html->add( |<td class="ro-detail">{ <ls_overview>-created_by }</td>| ).
      ii_html->add( |<td class="ro-detail">{ <ls_overview>-created_at }</td>| ).
      ii_html->add( |<td class="ro-detail">{ <ls_overview>-key }</td>| ).

      ii_html->add( |<td class='ro-action'> | ).

      lv_check_link = ii_html->a(
        iv_txt = |Check|
        iv_act = |{ zif_abapgit_definitions=>c_action-repo_code_inspector }?key={ <ls_overview>-key } | ).

      ii_html->add( lv_check_link && lc_separator ).

      IF <ls_overview>-type = abap_false. " online repo
        lv_stage_link = ii_html->a(
          iv_txt = |Stage|
          iv_act = |{ zif_abapgit_definitions=>c_action-go_stage }?key={ <ls_overview>-key } | ).

        ii_html->add( lv_stage_link && lc_separator ).

        lv_patch_link = ii_html->a(
          iv_txt = |Patch|
          iv_act = |{ zif_abapgit_definitions=>c_action-go_patch }?key={ <ls_overview>-key } | ).

        ii_html->add( lv_patch_link && lc_separator ).
      ELSE. " offline repo
        lv_zip_import_link = ii_html->a(
          iv_txt = |Import|
          iv_act = |{ zif_abapgit_definitions=>c_action-zip_import }?key={ <ls_overview>-key } | ).

        ii_html->add( lv_zip_import_link && lc_separator ).

        lv_zip_export_link = ii_html->a(
          iv_txt = |Export|
          iv_act = |{ zif_abapgit_definitions=>c_action-zip_export }?key={ <ls_overview>-key } | ).

        ii_html->add( lv_zip_export_link && lc_separator ).
      ENDIF.

      lv_settings_link = ii_html->a(
        iv_txt = |Settings|
        iv_act = |{ zif_abapgit_definitions=>c_action-repo_settings }?key={ <ls_overview>-key } | ).

      ii_html->add( lv_settings_link ).

      ii_html->add( |</td>| ).

      ii_html->add( |<td class='ro-go'><span>{
                ii_html->a(
                  iv_txt = `&rsaquo;`
                  iv_act = |{ c_action-select }?key={ <ls_overview>-key }| ) }</span></td>| ).

      ii_html->add( |</tr>| ).

    ENDLOOP.

    ii_html->add( |</tbody>| ).

  ENDMETHOD.