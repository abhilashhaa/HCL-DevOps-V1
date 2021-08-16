  METHOD create_characteristicref.

    CLEAR rv_charcinternalid.

    DATA(lv_batch_request) = th_mmim_odata_request_builder=>start_request(
        )->open_batch_request(
          )->open_changeset(
            )->open_change(
              )->set_http_operation( 'POST'
              )->set_uri( iv_uri = 'A_ClfnCharcRstrcnForKeyDate'
              )->set_body( iv_body = get_body(
                   is_charcrstrcn            = is_charcrstrcn
                   it_charcrstrcn_fieldname  = VALUE #( ( 'ClassType' )
                                                        ( 'CharcInternalID' ) )
                 )
          )->close_changeset(
        )->close_batch_request(
        )->close_request( ).

    " execute & check returned status code
    DATA(lv_reponse) = posturl( iv_uri          = '$batch'
                                iv_request      = lv_batch_request
                                iv_content_type = 'multipart/mixed;boundary=batch_boundary'
                                iv_accept       = 'application/json'
                                iv_status_code  = '202' ).

    " Get XML data line from response
    " TODO : move to reusable method
*    DATA: lt_response_line TYPE TABLE OF string.
*    DATA: lv_response_line_in_xml TYPE string.
*
*    SPLIT lv_reponse AT cl_abap_char_utilities=>newline INTO TABLE lt_response_line.
*
*    LOOP AT lt_response_line ASSIGNING FIELD-SYMBOL(<ls_response_line>).
*      IF NOT <ls_response_line> CP '<?xml*'.
*        DELETE lt_response_line.
*      ENDIF.
*    ENDLOOP.
*
*    READ TABLE lt_response_line INTO lv_response_line_in_xml INDEX 1.

*    DATA(lv_charcinternalid_as_string) = get_attribute_value_from_xml(
*      EXPORTING
*        iv_xml            = lv_response_line_in_xml
*        iv_attribute_name = 'CharcInternalID' ).
*
*    cl_abap_unit_assert=>assert_not_initial(
*      EXPORTING
*        act              = lv_charcinternalid_as_string
*        msg              = 'Newly created characteristic ID is not returned' ).

*    rv_charcinternalid = lv_charcinternalid_as_string.

  ENDMETHOD.