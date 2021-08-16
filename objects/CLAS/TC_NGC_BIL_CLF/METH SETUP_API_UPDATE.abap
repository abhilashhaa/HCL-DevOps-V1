  METHOD SETUP_API_UPDATE.

    cl_abap_testdouble=>configure_call( mo_ngc_api )->set_parameter(
      EXPORTING
        name  = 'eo_clf_api_result'
        value = io_ngc_clf_api_result
     )->ignore_parameter( name = 'it_classification_object'
     )->and_expect( )->is_called_once( ).
    mo_ngc_api->if_ngc_clf_api_write~update(
      EXPORTING
        it_classification_object = VALUE #( )
    ).

  ENDMETHOD.