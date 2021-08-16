  METHOD save.

    DATA: li_service TYPE REF TO if_w3_api_service.

    li_service = w3_api_create_new( is_attr ).

    w3_api_set_attributes(
        ii_service    = li_service
        is_attributes = is_attr  ).

    w3_api_set_parameters(
        ii_service    = li_service
        it_parameters = it_parameters  ).

    w3_api_save( li_service ).

  ENDMETHOD.