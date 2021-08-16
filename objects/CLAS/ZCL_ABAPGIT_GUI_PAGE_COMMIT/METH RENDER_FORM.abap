  METHOD render_form.

    CONSTANTS: lc_body_col_max TYPE i VALUE 150.

    DATA: li_user      TYPE REF TO zif_abapgit_persist_user.
    DATA: lv_user      TYPE string.
    DATA: lv_email     TYPE string.
    DATA: lv_s_param   TYPE string.
    DATA: lo_settings  TYPE REF TO zcl_abapgit_settings.
    DATA: lv_body_size TYPE i.
    DATA: lv_comment   TYPE string.
    DATA: lv_body      TYPE string.
    DATA: lv_author_name TYPE string.
    DATA: lv_author_email TYPE string.

* see https://git-scm.com/book/ch5-2.html
* commit messages should be max 50 characters
* body should wrap at 72 characters

    li_user = zcl_abapgit_persistence_user=>get_instance( ).

    lv_user  = li_user->get_repo_git_user_name( mo_repo->get_url( ) ).
    IF lv_user IS INITIAL.
      lv_user  = li_user->get_default_git_user_name( ).
    ENDIF.
    IF lv_user IS INITIAL.
      " get default from user master record
      lv_user = zcl_abapgit_user_master_record=>get_instance( sy-uname )->get_name( ).
    ENDIF.

    lv_email = li_user->get_repo_git_user_email( mo_repo->get_url( ) ).
    IF lv_email IS INITIAL.
      lv_email = li_user->get_default_git_user_email( ).
    ENDIF.
    IF lv_email IS INITIAL.
      " get default from user master record
      lv_email = zcl_abapgit_user_master_record=>get_instance( sy-uname )->get_email( ).
    ENDIF.

    IF ms_commit IS NOT INITIAL.
      lv_user = ms_commit-committer_name.
      lv_email = ms_commit-committer_email.
      lv_comment = ms_commit-comment.
      lv_body = ms_commit-body.
      lv_author_name = ms_commit-author_name.
      lv_author_email = ms_commit-author_email.
    ENDIF.

    IF lv_comment IS INITIAL.
      lv_comment = get_comment_default( ).
    ENDIF.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div class="form-container">' ).
    ri_html->add( '<form id="commit_form" class="aligned-form"'
               && ' method="post" action="sapevent:commit_post">' ).

    ri_html->add( render_text_input( iv_name  = 'committer_name'
                                     iv_label = 'Committer Name'
                                     iv_value = lv_user ) ).

    ri_html->add( render_text_input( iv_name  = 'committer_email'
                                     iv_label = 'Committer E-mail'
                                     iv_value = lv_email ) ).

    lo_settings = zcl_abapgit_persist_settings=>get_instance( )->read( ).

    lv_s_param = lo_settings->get_commitmsg_comment_length( ).

    ri_html->add( render_text_input( iv_name       = 'comment'
                                     iv_label      = 'Comment'
                                     iv_value      = lv_comment
                                     iv_max_length = lv_s_param ) ).

    ri_html->add( '<div class="row">' ).
    ri_html->add( '<label for="c-body">Body</label>' ).

    lv_body_size = lo_settings->get_commitmsg_body_size( ).
    IF lv_body_size > lc_body_col_max.
      lv_body_size = lc_body_col_max.
    ENDIF.
    ri_html->add( |<textarea id="c-body" name="body" rows="10" cols="| &&
                  |{ lv_body_size }">{ lv_body }</textarea>| ).

    ri_html->add( '<input type="submit" class="hidden-submit">' ).
    ri_html->add( '</div>' ).

    ri_html->add( '<div class="row">' ).
    ri_html->add( '<span class="cell"></span>' ).
    ri_html->add( '<span class="cell sub-title">Optionally,'
               && ' specify author (same as committer by default)</span>' ).
    ri_html->add( '</div>' ).

    ri_html->add( render_text_input( iv_name  = 'author_name'
                                     iv_label = 'Author Name'
                                     iv_value = lv_author_name ) ).

    ri_html->add( render_text_input( iv_name  = 'author_email'
                                     iv_label = 'Author E-mail'
                                     iv_value = lv_author_email ) ).

    ri_html->add( '</form>' ).
    ri_html->add( '</div>' ).

  ENDMETHOD.