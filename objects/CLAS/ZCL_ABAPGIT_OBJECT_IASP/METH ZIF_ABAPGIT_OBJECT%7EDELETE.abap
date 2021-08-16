  METHOD zif_abapgit_object~delete.

    DATA: li_service TYPE REF TO if_w3_api_service.

    li_service = w3_api_load( ).

    w3_api_set_changeable( li_service ).
    w3_api_delete( li_service ).
    w3_api_save( li_service ).

  ENDMETHOD.