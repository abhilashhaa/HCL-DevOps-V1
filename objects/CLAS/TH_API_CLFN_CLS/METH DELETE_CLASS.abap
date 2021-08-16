  METHOD delete_class.
    DATA(lv_batch_request) = th_mmim_odata_request_builder=>start_request(
    )->open_batch_request(
      )->open_changeset(
        )->open_change(
          )->set_http_operation( 'DELETE'
          )->set_uri( iv_uri = 'A_ClfnClassForKeyDate(ClassInternalID=' && '''' && iv_classinternalid && '''' && ')'
          )->set_if_match( iv_if_match =  '*'
              )->set_body( iv_body = get_body_class(  )
      )->close_changeset(
    )->close_batch_request(
    )->close_request( ).
    " execute & check returned status code
    DATA(lv_reponse) = me->posturl( iv_uri          = '$batch'
                             iv_request      = lv_batch_request
                             iv_content_type = 'multipart/mixed;boundary=batch_boundary'
                             iv_accept       = 'application/json'
                             iv_status_code  = '202' ) ##NEEDED.
  ENDMETHOD.