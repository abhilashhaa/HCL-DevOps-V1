  METHOD read_classes.

    me->geturl(
      iv_uri         = 'A_ProductClass?$top=10'
      iv_status_code = 200 ).

  ENDMETHOD.