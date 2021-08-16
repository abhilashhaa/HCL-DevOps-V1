  METHOD constructor.

    DATA: lt_events TYPE cntl_simple_events,
          ls_event  LIKE LINE OF lt_events.

    CREATE OBJECT mo_html_viewer
      EXPORTING
        query_table_disabled = abap_true
        parent               = cl_gui_container=>screen0.

    ls_event-eventid    = zif_abapgit_html_viewer=>m_id_sapevent.
    ls_event-appl_event = abap_true.
    APPEND ls_event TO lt_events.

    mo_html_viewer->set_registered_events( lt_events ).
    SET HANDLER me->on_event FOR mo_html_viewer.

  ENDMETHOD.