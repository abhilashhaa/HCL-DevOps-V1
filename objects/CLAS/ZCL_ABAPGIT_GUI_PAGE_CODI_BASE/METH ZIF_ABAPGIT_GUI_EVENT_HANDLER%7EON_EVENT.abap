  METHOD zif_abapgit_gui_event_handler~on_event.
    DATA: ls_item          TYPE zif_abapgit_definitions=>ty_item,
          ls_sub_item      TYPE zif_abapgit_definitions=>ty_item,
          lv_temp          TYPE string,
          lv_main_object   TYPE string,
          lv_sub_object    TYPE string,
          lv_line_number_s TYPE string,
          lv_line_number   TYPE i.

    lv_temp = replace( val   = ii_event->mv_action
                       regex = |^{ c_ci_sig }|
                       with  = `` ).

    IF lv_temp <> ii_event->mv_action. " CI navigation request detected

      SPLIT lv_temp AT c_object_separator INTO lv_main_object lv_sub_object lv_line_number_s.
      ls_item-obj_type = lv_main_object(4).
      ls_item-obj_name = lv_main_object+4(*).

      IF lv_sub_object IS NOT INITIAL.
        ls_sub_item-obj_type = lv_sub_object(4).
        ls_sub_item-obj_name = lv_sub_object+4(*).
      ENDIF.

      lv_line_number = lv_line_number_s.

      jump( is_item        = ls_item
            is_sub_item    = ls_sub_item
            iv_line_number = lv_line_number ).

      rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.

    ENDIF.

    CASE ii_event->mv_action.

      WHEN c_actions-sort_1.
        SORT mt_result BY objtype objname test code sobjtype sobjname line col.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN c_actions-sort_2.
        SORT mt_result BY objtype objname sobjtype sobjname line col test code.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN c_actions-sort_3.
        SORT mt_result BY test code objtype objname sobjtype sobjname line col.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

    ENDCASE.

  ENDMETHOD.