  METHOD get_changed_time.

    DATA: lv_changed_time_external TYPE string.

    lv_changed_time_external = ii_document->find_from_name( 'LTIME' )->get_value( ).

    REPLACE ALL OCCURRENCES OF ':' IN lv_changed_time_external WITH ''.
    rv_changed_time = lv_changed_time_external.

  ENDMETHOD.