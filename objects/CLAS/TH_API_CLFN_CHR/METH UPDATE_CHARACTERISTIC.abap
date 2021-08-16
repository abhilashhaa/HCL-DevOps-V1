  METHOD UPDATE_CHARACTERISTIC.

    DATA(lv_batch_request_class) = th_mmim_odata_request_builder=>start_request(
        )->open_batch_request(
          )->open_changeset(
            )->open_change(
              )->set_http_operation( 'PATCH'
              )->set_uri( iv_uri = |A_ClfnCharacteristicForKeyDate(CharcInternalID='{ is_charc-charcinternalid }')|
              )->set_if_match( iv_if_match =  '*'
              )->set_body( iv_body = get_body_characteristic(
                   is_charc                    = is_charc
                   it_charc_fieldname          = VALUE #( ( 'Characteristic' )
                                                          ( 'CharcDataType' )
                                                          ( 'CharcLength' )
                                                          ( 'CharcDecimals' )
                                                          ( 'CharcStatus' )
                                                          ( 'CharcHasSingleValue' )
*                                                          ( 'ValueIsCaseSensitive' )
*                                                          ( 'CharcTemplate' )
*                                                          ( 'CharcStatus' )
*                                                          ( 'EntryIsRequired' )
*                                                          ( 'ValueIntervalIsAllowed' )
*                                                          ( 'AdditionalValueIsAllowed' )
                                                        )
                 )

          )->close_changeset(
        )->close_batch_request(
        )->close_request( ).

    " execute & check returned status code
    DATA(lv_reponse) = posturl( iv_uri          = '$batch'
                                iv_request      = lv_batch_request_class
                                iv_content_type = 'multipart/mixed;boundary=batch_boundary'
                                iv_accept       = 'application/json'
                                iv_status_code  = '202' ).

  ENDMETHOD.