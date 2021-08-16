  METHOD zif_abapgit_object~delete.

    DATA: li_resource TYPE REF TO if_w3_api_resource.

    li_resource = w3_api_load( ).
    w3_api_set_changeable( li_resource ).
    w3_api_delete( li_resource ).
    w3_api_save( li_resource ).

  ENDMETHOD.