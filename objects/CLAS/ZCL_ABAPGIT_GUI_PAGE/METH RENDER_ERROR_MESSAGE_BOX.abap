  METHOD render_error_message_box.

    " You should remember that the we have to instantiate ro_html even
    " it's overwritten further down. Because ADD checks whether it's
    " bound.
    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    " You should remember that we render the message panel only
    " if we have an error.
    IF mx_error IS NOT BOUND.
      RETURN.
    ENDIF.

    ri_html = zcl_abapgit_gui_chunk_lib=>render_error_message_box( mx_error ).

    " You should remember that the exception viewer dispatches the events of
    " error message panel
    CREATE OBJECT mo_exception_viewer
      EXPORTING
        ix_error = mx_error.

    " You should remember that we render the message panel just once
    " for each exception/error text.
    CLEAR:
      mx_error.

  ENDMETHOD.