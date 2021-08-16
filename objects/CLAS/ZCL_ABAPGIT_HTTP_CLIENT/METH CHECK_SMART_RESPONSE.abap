  METHOD check_smart_response.

    DATA: lv_content_type TYPE string.
    DATA: lv_data         TYPE string.

    IF iv_expected_content_type IS NOT INITIAL.
      lv_content_type = mi_client->response->get_content_type( ).
      IF lv_content_type <> iv_expected_content_type.
        zcx_abapgit_exception=>raise( 'Wrong Content-Type sent by server - no fallback to the dumb protocol!' ).
      ENDIF.
    ENDIF.

    IF iv_content_regex IS NOT INITIAL.
      lv_data = mi_client->response->get_cdata( ).
      FIND REGEX iv_content_regex IN lv_data.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'Wrong Content sent by server' ).
      ENDIF.
    ENDIF.

  ENDMETHOD.