  METHOD update_class_charc.
    DATA: lt_classcharc TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classcharc.
    APPEND is_classcharc TO lt_classcharc.
    DATA(lv_batch_request_class) = th_mmim_odata_request_builder=>start_request(
        )->open_batch_request(
          )->open_changeset(
            )->open_change(
              )->set_http_operation( 'PUT'
              )->set_uri( iv_uri = 'A_ClfnClassCharcForKeyDate(ClassInternalID=' && '''' && is_classcharc-classinternalid && '''' && ',' &&
                                                              'CharcInternalID=' && '''' && is_classcharc-charcinternalid &&'''' && ')'
              )->set_body( iv_body = me->get_body(
                   it_classcharc  = lt_classcharc
                   it_fieldname     = VALUE #( ( 'Characteristic' ) ( 'CharcIsSearchRelevant' ) ( 'CharcPositionNumber' ) ) )
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