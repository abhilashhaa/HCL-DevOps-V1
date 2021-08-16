  METHOD render_diff_head_after_state.

    DATA: lv_act_id TYPE string.

    IF is_diff-obj_type IS NOT INITIAL AND is_diff-obj_name IS NOT INITIAL.

      lv_act_id = |{ c_actions-refresh_local_object }_{ is_diff-obj_type }_{ is_diff-obj_name }|.

      ii_html->add_a(
          iv_txt   = |Refresh|
          iv_typ   = zif_abapgit_html=>c_action_type-dummy
          iv_act   = lv_act_id
          iv_id    = lv_act_id
          iv_title = |Local refresh of this object| ).

    ENDIF.

    super->render_diff_head_after_state(
        ii_html = ii_html
        is_diff = is_diff ).

  ENDMETHOD.