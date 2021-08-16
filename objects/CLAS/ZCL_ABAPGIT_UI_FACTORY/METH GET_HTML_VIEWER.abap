  METHOD get_html_viewer.

    IF gi_html_viewer IS BOUND.
      ri_viewer = gi_html_viewer.
      RETURN.
    ENDIF.

    CREATE OBJECT ri_viewer TYPE zcl_abapgit_html_viewer_gui.

  ENDMETHOD.