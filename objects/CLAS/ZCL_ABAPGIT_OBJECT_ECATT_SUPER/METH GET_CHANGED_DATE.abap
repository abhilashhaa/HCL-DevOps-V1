  METHOD get_changed_date.

    DATA: lv_changed_date_external TYPE string.

    lv_changed_date_external = ii_document->find_from_name( 'LDATE' )->get_value( ).

    REPLACE ALL OCCURRENCES OF '-' IN lv_changed_date_external WITH ''.
    rv_changed_date = lv_changed_date_external.

  ENDMETHOD.