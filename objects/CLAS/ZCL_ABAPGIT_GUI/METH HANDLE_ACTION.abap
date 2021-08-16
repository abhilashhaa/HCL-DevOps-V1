  METHOD handle_action.

    DATA:
      lx_exception TYPE REF TO zcx_abapgit_exception,
      li_handler   TYPE REF TO zif_abapgit_gui_event_handler,
      li_event     TYPE REF TO zif_abapgit_gui_event,
      ls_handled   TYPE zif_abapgit_gui_event_handler=>ty_handling_result.

    CREATE OBJECT li_event TYPE zcl_abapgit_gui_event
      EXPORTING
        ii_gui_services = me
        iv_action       = iv_action
        iv_getdata      = iv_getdata
        it_postdata     = it_postdata.

    TRY.
        LOOP AT mt_event_handlers INTO li_handler.
          ls_handled = li_handler->on_event( li_event ).
          IF ls_handled-state IS NOT INITIAL AND ls_handled-state <> c_event_state-not_handled. " is handled
            EXIT.
          ENDIF.
        ENDLOOP.

        CASE ls_handled-state.
          WHEN c_event_state-re_render.
            render( ).
          WHEN c_event_state-new_page.
            call_page( ls_handled-page ).
          WHEN c_event_state-new_page_w_bookmark.
            call_page(
              ii_page = ls_handled-page
              iv_with_bookmark = abap_true ).
          WHEN c_event_state-new_page_replacing.
            call_page(
              ii_page = ls_handled-page
              iv_replacing = abap_true ).
          WHEN c_event_state-go_back.
            back( ).
          WHEN c_event_state-go_back_to_bookmark.
            back( abap_true ).
          WHEN c_event_state-no_more_act.
            " Do nothing, handling completed
          WHEN OTHERS.
            zcx_abapgit_exception=>raise( |Unknown action: { iv_action }| ).
        ENDCASE.

      CATCH zcx_abapgit_cancel ##NO_HANDLER.
        " Do nothing = gc_event_state-no_more_act
      CATCH zcx_abapgit_exception INTO lx_exception.
        handle_error( lx_exception ).
    ENDTRY.

  ENDMETHOD.