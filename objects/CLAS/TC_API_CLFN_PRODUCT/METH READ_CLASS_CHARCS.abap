  METHOD read_class_charcs.

    me->geturl(
      iv_uri         = 'A_ProductClassCharc?$top=10'
      iv_status_code = 200 ).

  ENDMETHOD.