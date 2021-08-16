  METHOD render_deferred_hidden_events.

    DATA ls_event TYPE zcl_abapgit_gui_chunk_lib=>ty_event_signature.

    ls_event-method = 'post'.
    ls_event-name   = 'stage_commit'.
    ri_html = zcl_abapgit_gui_chunk_lib=>render_event_as_form( ls_event ).
    ri_html->set_title( cl_abap_typedescr=>describe_by_object_ref( me )->get_relative_name( ) ).

  ENDMETHOD.