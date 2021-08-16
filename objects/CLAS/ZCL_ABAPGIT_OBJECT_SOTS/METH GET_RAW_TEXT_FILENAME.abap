  METHOD get_raw_text_filename.

    rv_filename =
        to_lower( |{ is_entry-concept }_|
               && |{ is_entry-langu   }_|
               && |{ is_entry-object  }_|
               && |{ is_entry-lfd_num }| ).

  ENDMETHOD.