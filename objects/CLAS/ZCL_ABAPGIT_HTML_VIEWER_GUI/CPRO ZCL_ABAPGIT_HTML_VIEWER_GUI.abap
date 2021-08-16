  PROTECTED SECTION.

    DATA mo_html_viewer TYPE REF TO cl_gui_html_viewer .

    METHODS on_event
          FOR EVENT sapevent OF cl_gui_html_viewer
      IMPORTING
          !action
          !frame
          !getdata
          !postdata
          !query_table .
