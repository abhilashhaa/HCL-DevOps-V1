  METHOD extract_classname.

    rv_classname = substring_before( val   = iv_mainprogram
                                     regex = '=*CP$' ).

  ENDMETHOD.