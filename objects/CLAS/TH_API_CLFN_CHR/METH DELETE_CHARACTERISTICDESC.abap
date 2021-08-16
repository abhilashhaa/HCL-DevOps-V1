  METHOD DELETE_CHARACTERISTICDESC.

    DATA(lv_batch_request) = th_mmim_odata_request_builder=>start_request(
      )->open_batch_request(
      )->open_changeset(
      )->open_change(
      )->set_http_operation( 'DELETE'
      )->set_uri( iv_uri = |A_ClfnCharcDescForKeyDate(CharcInternalID='{ iv_charcinternalid }',Language='{ iv_language }')|
      )->set_if_match( iv_if_match =  '*'
      )->close_changeset(
      )->close_batch_request(
      )->close_request( ).

    " execute & check returned status code
    DATA(lv_reponse) = posturl(
      iv_uri          = '$batch'
      iv_request      = lv_batch_request
      iv_content_type = 'multipart/mixed;boundary=batch_boundary'
      iv_accept       = 'application/json'
      iv_status_code  = '202' ) . "gc_status_code_accepted ).

  ENDMETHOD.