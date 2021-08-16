  METHOD apply_patch_from_form_fields.

    DATA:
      lt_fields TYPE tihttpnvp,
      lv_add    TYPE string,
      lv_remove TYPE string.

    lt_fields = zcl_abapgit_html_action_utils=>parse_post_form_data( it_postdata ).

    zcl_abapgit_html_action_utils=>get_field( EXPORTING iv_name  = c_patch_action-add
                                                        it_field = lt_fields
                                              CHANGING  cg_field = lv_add ).

    zcl_abapgit_html_action_utils=>get_field( EXPORTING iv_name  = c_patch_action-remove
                                                        it_field = lt_fields
                                              CHANGING  cg_field = lv_remove ).

    apply_patch_all( iv_patch      = lv_add
                     iv_patch_flag = abap_true ).

    apply_patch_all( iv_patch      = lv_remove
                     iv_patch_flag = abap_false ).

  ENDMETHOD.