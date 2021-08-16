  METHOD SETUP_API_RESULT.

    ro_ngc_clf_api_result = NEW #( ).

    IF iv_msgty IS SUPPLIED.
      ro_ngc_clf_api_result->add_messages( it_message = VALUE #( ( msgty = iv_msgty ) ) ).
    ENDIF.

    IF it_message IS SUPPLIED.
      ro_ngc_clf_api_result->add_messages( it_message = it_message ).
    ENDIF.

  ENDMETHOD.