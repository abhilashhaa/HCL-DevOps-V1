  METHOD post_commit_msg.

    DATA: lv_i_param_value TYPE i.

    FIELD-SYMBOLS: <ls_post_field> TYPE ihttpnvp.


    READ TABLE mt_post_fields ASSIGNING <ls_post_field> WITH KEY name = 'comment_length'.
    IF sy-subrc = 0.
      lv_i_param_value = <ls_post_field>-value.
      IF lv_i_param_value < zcl_abapgit_settings=>c_commitmsg_comment_length_dft.
        lv_i_param_value = zcl_abapgit_settings=>c_commitmsg_comment_length_dft.
      ENDIF.
      mo_settings->set_commitmsg_comment_length( lv_i_param_value ).
    ELSE.
      mo_settings->set_commitmsg_comment_length( zcl_abapgit_settings=>c_commitmsg_comment_length_dft ).
    ENDIF.

    READ TABLE mt_post_fields ASSIGNING <ls_post_field> WITH KEY name = 'comment_default'.
    IF sy-subrc = 0.
      mo_settings->set_commitmsg_comment_default( <ls_post_field>-value ).
    ENDIF.

    READ TABLE mt_post_fields ASSIGNING <ls_post_field> WITH KEY name = 'body_size'.
    IF sy-subrc = 0.
      lv_i_param_value = <ls_post_field>-value.
      IF lv_i_param_value < zcl_abapgit_settings=>c_commitmsg_body_size_dft.
        lv_i_param_value = zcl_abapgit_settings=>c_commitmsg_body_size_dft.
      ENDIF.
      mo_settings->set_commitmsg_body_size( lv_i_param_value ).
    ELSE.
      mo_settings->set_commitmsg_body_size( zcl_abapgit_settings=>c_commitmsg_body_size_dft ).
    ENDIF.

  ENDMETHOD.