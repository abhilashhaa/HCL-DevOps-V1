  METHOD setup_api_read.

    IF it_classificaton_object IS SUPPLIED.
      cl_abap_testdouble=>configure_call( mo_ngc_api )->set_parameter(
        EXPORTING
          name  = 'eo_clf_api_result'
          value = io_ngc_clf_api_result
       )->set_parameter(
        EXPORTING
          name  = 'et_classification_object'
          value = it_classificaton_object
       )->ignore_parameter( name = 'it_classification_key' ).
      mo_ngc_api->if_ngc_clf_api_read~read(
        EXPORTING
          it_classification_key    = VALUE #( )
      ).
    ELSE.
      cl_abap_testdouble=>configure_call( mo_ngc_api )->set_parameter(
        EXPORTING
          name  = 'eo_clf_api_result'
          value = io_ngc_clf_api_result
       )->set_parameter(
        EXPORTING
          name  = 'et_classification_object'
          value = VALUE ngct_classification_object( ( object_key       = is_classification_key-object_key
                                                      technical_object = is_classification_key-technical_object
                                                      change_number    = is_classification_key-change_number
                                                      key_date         = is_classification_key-key_date
                                                      classification   = mo_ngc_classification ) )
       )->ignore_parameter( name = 'it_classification_key' ).
      mo_ngc_api->if_ngc_clf_api_read~read(
        EXPORTING
          it_classification_key    = VALUE #( )
      ).
    ENDIF.

  ENDMETHOD.