  METHOD zif_abapgit_gui_event_handler~on_event.

    DATA: ls_merge TYPE ty_merge,
          lo_merge TYPE REF TO zcl_abapgit_gui_page_merge.


    CASE ii_event->mv_action.
      WHEN c_actions-refresh.
        refresh( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN c_actions-uncompress.
        mv_compress = abap_false.
        refresh( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN c_actions-compress.
        mv_compress = abap_true.
        refresh( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN c_actions-merge.
        ls_merge = decode_merge( ii_event->mt_postdata ).
        CREATE OBJECT lo_merge
          EXPORTING
            io_repo   = mo_repo
            iv_source = ls_merge-source
            iv_target = ls_merge-target.
        rs_handled-page = lo_merge.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN OTHERS.
        rs_handled = super->zif_abapgit_gui_event_handler~on_event( ii_event ).
    ENDCASE.

  ENDMETHOD.