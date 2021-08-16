  METHOD read_charc.

    me->geturl(
      iv_uri         = 'A_ProductCharc?$top=10'
      iv_status_code = 200 ).

  ENDMETHOD.