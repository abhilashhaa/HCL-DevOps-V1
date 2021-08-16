  METHOD update_class_keyword.
    DATA: lt_classkeyword TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classkeyword.
    APPEND is_classkeyword TO lt_classkeyword.
    DATA(lv_batch_request_class) = th_mmim_odata_request_builder=>start_request(
        )->open_batch_request(
          )->open_changeset(
            )->open_change(
              )->set_http_operation( 'PUT'
              )->set_uri( iv_uri = 'A_ClfnClassKeywordForKeyDate(ClassInternalID=' && '''' && is_classkeyword-classinternalid && '''' && ',' &&
                                                                'ClassKeywordPositionNumber=' && '''' && is_classkeyword-classkeywordpositionnumber && '''' && ',' &&
                                                                'Language=' && '''' && is_classkeyword-language &&'''' && ')'
              )->set_body( iv_body = me->get_body(
                   it_classkeyword  = lt_classkeyword
                   it_fieldname     = VALUE #( ( 'ClassKeywordText' ) ) )
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