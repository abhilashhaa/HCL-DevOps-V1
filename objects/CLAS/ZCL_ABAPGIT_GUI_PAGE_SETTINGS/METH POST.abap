  METHOD post.

    DATA lv_i_param_value TYPE i.
    DATA lv_c_param_value TYPE c.

    FIELD-SYMBOLS: <ls_post_field> TYPE ihttpnvp.


    CREATE OBJECT mo_settings.
    mt_post_fields = it_post_fields.


    post_proxy( ).
    post_commit_msg( ).
    post_development_internals( ).

* todo, refactor to private POST_* methods
    IF is_post_field_checked( 'show_default_repo' ) = abap_true.
      mo_settings->set_show_default_repo( abap_true ).
    ELSE.
      mo_settings->set_show_default_repo( abap_false ).
    ENDIF.

    READ TABLE mt_post_fields ASSIGNING <ls_post_field> WITH KEY name = 'max_lines'.
    IF sy-subrc = 0.
      lv_i_param_value = <ls_post_field>-value.
      mo_settings->set_max_lines( lv_i_param_value ).
    ELSE.
      mo_settings->set_max_lines( 0 ).
    ENDIF.

    IF is_post_field_checked( 'adt_jump_enabled' ) = abap_true.
      mo_settings->set_adt_jump_enanbled( abap_true ).
    ELSE.
      mo_settings->set_adt_jump_enanbled( abap_false ).
    ENDIF.

    IF is_post_field_checked( 'link_hints_enabled' ) = abap_true.
      mo_settings->set_link_hints_enabled( abap_true ).
    ELSE.
      mo_settings->set_link_hints_enabled( abap_false ).
    ENDIF.

    READ TABLE mt_post_fields ASSIGNING <ls_post_field> WITH KEY name = 'link_hint_key'.
    IF sy-subrc = 0.
      mo_settings->set_link_hint_key( |{ <ls_post_field>-value }| ).
    ENDIF.

    IF is_post_field_checked( 'parallel_proc_disabled' ) = abap_true.
      mo_settings->set_parallel_proc_disabled( abap_true ).
    ELSE.
      mo_settings->set_parallel_proc_disabled( abap_false ).
    ENDIF.

    READ TABLE mt_post_fields ASSIGNING <ls_post_field> WITH KEY name = 'icon_scaling'.
    IF sy-subrc = 0.
      lv_c_param_value = <ls_post_field>-value.
      mo_settings->set_icon_scaling( lv_c_param_value ).
    ELSE.
      mo_settings->set_icon_scaling( '' ).
    ENDIF.

    READ TABLE mt_post_fields ASSIGNING <ls_post_field> WITH KEY name = 'ui_theme'.
    IF sy-subrc = 0.
      mo_settings->set_ui_theme( <ls_post_field>-value ).
    ELSE.
      mo_settings->set_ui_theme( zcl_abapgit_settings=>c_ui_theme-default ).
    ENDIF.

    post_hotkeys( ).

  ENDMETHOD.