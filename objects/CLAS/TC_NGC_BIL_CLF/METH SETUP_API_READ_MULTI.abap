  METHOD setup_api_read_multi.

    DATA:
      lt_classification_object TYPE ngct_classification_object.

    LOOP AT it_classification_key ASSIGNING FIELD-SYMBOL(<ls_classification_key>).
      APPEND VALUE #( object_key       = <ls_classification_key>-object_key
                      technical_object = <ls_classification_key>-technical_object
                      change_number    = <ls_classification_key>-change_number
                      key_date         = <ls_classification_key>-key_date
                      classification   = mo_ngc_classification ) TO lt_classification_object.
    ENDLOOP.

    cl_abap_testdouble=>configure_call( mo_ngc_api )->set_parameter(
      EXPORTING
        name  = 'eo_clf_api_result'
        value = io_ngc_clf_api_result
     )->set_parameter(
      EXPORTING
        name  = 'et_classification_object'
        value = lt_classification_object
     )->ignore_parameter( name = 'it_classification_key' ).
    mo_ngc_api->if_ngc_clf_api_read~read(
      EXPORTING
        it_classification_key    = VALUE #( )
    ).

  ENDMETHOD.