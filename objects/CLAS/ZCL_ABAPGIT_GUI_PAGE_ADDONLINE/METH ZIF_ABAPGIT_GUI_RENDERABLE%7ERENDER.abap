  METHOD zif_abapgit_gui_renderable~render.

    gui_services( )->register_event_handler( me ).

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( mo_form->render(
      iv_form_class     = 'dialog w600px m-em5-sides margin-v1' " to center add wmax600px and auto-center instead
      io_values         = mo_form_data
      io_validation_log = mo_validation_log ) ).

  ENDMETHOD.