  METHOD popup_get_from_free_selections.
    DATA: lo_free_sel_dialog TYPE REF TO zcl_abapgit_free_sel_dialog.

    CREATE OBJECT lo_free_sel_dialog
      EXPORTING
        iv_title      = iv_title
        iv_frame_text = iv_frame_text.

    lo_free_sel_dialog->set_fields( CHANGING ct_fields = ct_fields ).
    lo_free_sel_dialog->show( ).
  ENDMETHOD.