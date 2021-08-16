  METHOD set_defaults.

    CLEAR ms_settings.

    set_proxy_authentication( abap_false ).
    set_run_critical_tests( abap_false ).
    set_experimental_features( abap_false ).
    set_max_lines( 500 ).
    set_adt_jump_enanbled( abap_true ).
    set_show_default_repo( abap_false ).
    set_commitmsg_comment_length( c_commitmsg_comment_length_dft ).
    set_commitmsg_body_size( c_commitmsg_body_size_dft ).
    set_default_link_hint_key( ).
    set_icon_scaling( '' ).

  ENDMETHOD.