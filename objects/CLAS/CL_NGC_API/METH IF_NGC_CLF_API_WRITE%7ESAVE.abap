METHOD if_ngc_clf_api_write~save.

  mo_clf_persistency->save( ).
  mo_clf_persistency->cleanup( ).

ENDMETHOD.