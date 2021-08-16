  METHOD read.

    DATA: li_resource TYPE REF TO if_w3_api_resource.

    li_resource = w3_api_load( ).
    es_attributes = w3_api_get_attributes( li_resource ).

    CLEAR: es_attributes-chname,
           es_attributes-tdate,
           es_attributes-ttime,
           es_attributes-devclass.

    et_parameters = w3_api_get_parameters( li_resource ).

  ENDMETHOD.