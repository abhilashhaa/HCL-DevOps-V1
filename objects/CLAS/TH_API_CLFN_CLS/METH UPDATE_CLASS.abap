  METHOD update_class.
    DATA(lv_batch_request_class) = th_mmim_odata_request_builder=>start_request(
        )->open_batch_request(
          )->open_changeset(
            )->open_change(
              )->set_http_operation( 'PATCH'
              )->set_uri( iv_uri = 'A_ClfnClassForKeyDate(ClassInternalID=' && '''' && is_class-classinternalid && '''' && ')'
              )->set_body( iv_body = me->get_body_class(
                   is_class            = is_class
                   it_class_fieldname = VALUE #( ( 'ClassMaintAuthGrp' ) ( 'SameClassfctnReaction' ) ) )
              )->set_if_match( iv_if_match = '*'
          )->close_changeset(
        )->close_batch_request(
        )->close_request( ).
    " execute & check returned status code
    DATA(lv_reponse) = me->posturl(
                             iv_uri          = '$batch'
                             iv_request      = lv_batch_request_class
                             iv_content_type = 'multipart/mixed;boundary=batch_boundary'
                             iv_accept       = 'application/json'
                             iv_status_code  = '202' ) ##NEEDED.
  ENDMETHOD.