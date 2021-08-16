  METHOD render_form.

    CONSTANTS: lc_body_col_max TYPE i VALUE 150.

    DATA: li_user      TYPE REF TO zif_abapgit_persist_user,
          lv_user      TYPE string,
          lv_email     TYPE string,
          lv_s_param   TYPE string,
          lo_settings  TYPE REF TO zcl_abapgit_settings,
          lv_body_size TYPE i,
          lt_type      TYPE string_table,
          lv_selected  TYPE string.

    FIELD-SYMBOLS: <lv_type> LIKE LINE OF lt_type.


    li_user = zcl_abapgit_persistence_user=>get_instance( ).

    lv_user = li_user->get_repo_git_user_name( mo_repo_online->get_url( ) ).
    IF lv_user IS INITIAL.
      lv_user = li_user->get_default_git_user_name( ).
    ENDIF.
    IF lv_user IS INITIAL.
      " get default from user master record
      lv_user = zcl_abapgit_user_master_record=>get_instance( sy-uname )->get_name( ).
    ENDIF.

    lv_email = li_user->get_repo_git_user_email( mo_repo_online->get_url( ) ).
    IF lv_email IS INITIAL.
      lv_email = li_user->get_default_git_user_email( ).
    ENDIF.
    IF lv_email IS INITIAL.
      " get default from user master record
      lv_email = zcl_abapgit_user_master_record=>get_instance( sy-uname )->get_email( ).
    ENDIF.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div class="form-container">' ).
    ri_html->add( '<form id="commit_form" class="aligned-form grey70"'
               && ' method="post" action="sapevent:commit_post">' ).

    INSERT c_tag_type-lightweight
           INTO TABLE lt_type.

    INSERT c_tag_type-annotated
           INTO TABLE lt_type.

    ri_html->add( '<div class="row">' ).
    ri_html->add( 'Tag type <select name="folder_logic" onchange="onTagTypeChange(this)">' ).

    LOOP AT lt_type ASSIGNING <lv_type>.

      IF mv_selected_type = <lv_type>.
        lv_selected = 'selected'.
      ELSE.
        CLEAR: lv_selected.
      ENDIF.

      ri_html->add( |<option value="{ <lv_type> }" | && |{ lv_selected }>| && |{ <lv_type> }</option>| ).

    ENDLOOP.

    ri_html->add( '</div>' ).

    ri_html->add( '</select>' ).
    ri_html->add( '<br>' ).
    ri_html->add( '<br>' ).

    ri_html->add( render_text_input( iv_name  = 'sha1'
                                     iv_label = 'SHA1'
                                     iv_value = mo_repo_online->get_sha1_remote( ) ) ).

    ri_html->add( render_text_input( iv_name  = 'name'
                                     iv_label = 'tag name' ) ).

    IF mv_selected_type = c_tag_type-annotated.

      ri_html->add( render_text_input( iv_name  = 'tagger_name'
                                       iv_label = 'tagger name'
                                       iv_value = lv_user ) ).

      ri_html->add( render_text_input( iv_name  = 'tagger_email'
                                       iv_label = 'tagger e-mail'
                                       iv_value = lv_email ) ).

      lo_settings = zcl_abapgit_persist_settings=>get_instance( )->read( ).

      lv_s_param = lo_settings->get_commitmsg_comment_length( ).

      ri_html->add( render_text_input( iv_name       = 'message'
                                       iv_label      = 'message'
                                       iv_max_length = lv_s_param ) ).

      ri_html->add( '<div class="row">' ).
      ri_html->add( '<label for="c-body">body</label>' ).

      lv_body_size = lo_settings->get_commitmsg_body_size( ).
      IF lv_body_size > lc_body_col_max.
        lv_body_size = lc_body_col_max.
      ENDIF.
      ri_html->add( |<textarea id="c-body" name="body" rows="10" cols="{ lv_body_size }"></textarea>| ).

    ENDIF.

    ri_html->add( '<input type="submit" class="hidden-submit">' ).
    ri_html->add( '</div>' ).

    ri_html->add( '</form>' ).
    ri_html->add( '</div>' ).

  ENDMETHOD.