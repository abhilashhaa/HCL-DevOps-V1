  METHOD zif_abapgit_gui_event_handler~on_event.

    DATA: lo_stage  TYPE REF TO zcl_abapgit_stage,
          lt_fields TYPE tihttpnvp.

    CASE ii_event->mv_action.
      WHEN c_action-stage_all.

        lo_stage = stage_all( ).

        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_commit
          EXPORTING
            io_repo  = mo_repo
            io_stage = lo_stage.

        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.

      WHEN c_action-stage_commit.

        lo_stage = stage_selected( ii_event->mt_postdata ).

        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_commit
          EXPORTING
            io_repo  = mo_repo
            io_stage = lo_stage.

        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.

      WHEN c_action-stage_filter.

        lt_fields = zcl_abapgit_html_action_utils=>parse_post_form_data( ii_event->mt_postdata ).

        zcl_abapgit_html_action_utils=>get_field(
          EXPORTING
            iv_name  = 'filterValue'
            it_field = lt_fields
          CHANGING
            cg_field = mv_filter_value ).

        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.

      WHEN zif_abapgit_definitions=>c_action-go_patch.                         " Go Patch page

        lo_stage = stage_selected( ii_event->mt_postdata ).
        rs_handled-page  = get_page_patch( lo_stage ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.

      WHEN OTHERS.
        rs_handled = super->zif_abapgit_gui_event_handler~on_event( ii_event ).
    ENDCASE.

  ENDMETHOD.