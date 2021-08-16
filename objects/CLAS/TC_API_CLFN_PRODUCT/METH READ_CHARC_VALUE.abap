  METHOD read_charc_value.

    me->geturl(
      iv_uri         = 'A_ProductCharcValue?$top=10'
      iv_status_code = 200 ).

  ENDMETHOD.