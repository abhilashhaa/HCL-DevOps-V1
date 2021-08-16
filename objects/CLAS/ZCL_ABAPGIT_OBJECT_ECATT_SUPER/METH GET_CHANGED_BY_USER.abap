  METHOD get_changed_by_user.

    rv_changed_by_user = ii_document->find_from_name( 'LUSER' )->get_value( ).

  ENDMETHOD.