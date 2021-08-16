  METHOD save.

    DATA: lt_post_fields TYPE tihttpnvp,
          lv_msg         TYPE string.

    lt_post_fields = zcl_abapgit_html_action_utils=>parse_post_form_data( it_postdata ).

    save_dot_abap( lt_post_fields ).
    save_remotes( lt_post_fields ).
    save_local_settings( lt_post_fields ).

    mo_repo->refresh( ).

    lv_msg = |{ mo_repo->get_name( ) }: settings saved successfully.|.
    MESSAGE lv_msg TYPE 'S'.

  ENDMETHOD.