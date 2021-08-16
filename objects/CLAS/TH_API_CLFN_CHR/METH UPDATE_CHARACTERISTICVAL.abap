  METHOD UPDATE_CHARACTERISTICVAL.

    DATA(lv_batch_request_class) = th_mmim_odata_request_builder=>start_request(
        )->open_batch_request(
          )->open_changeset(
            )->open_change(
              )->set_http_operation( 'PATCH'
              )->set_uri( iv_uri = |A_ClfnCharcValueForKeyDate(CharcInternalID='{ is_charc_val-charcinternalid }',CharcValuePositionNumber='{ is_charc_val-charcvaluepositionnumber }')|
              )->set_if_match( iv_if_match =  '*'
              )->set_body( iv_body = get_body(
                     is_charcvalue            = is_charc_val
                     it_charcvalue_fieldname  = VALUE #( ( 'CharcValue' )
                                                        ( 'CharcValueDependency' ) )
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