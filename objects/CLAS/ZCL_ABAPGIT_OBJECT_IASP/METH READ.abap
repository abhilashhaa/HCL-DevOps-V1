  METHOD read.

    DATA: li_service TYPE REF TO if_w3_api_service.

    li_service = w3_api_load( ).
    es_attr = w3_api_get_attributes( li_service ).

    CLEAR: es_attr-chname,
           es_attr-tdate,
           es_attr-ttime,
           es_attr-devclass.

    et_parameters = w3_api_get_parameters( li_service ).

  ENDMETHOD.