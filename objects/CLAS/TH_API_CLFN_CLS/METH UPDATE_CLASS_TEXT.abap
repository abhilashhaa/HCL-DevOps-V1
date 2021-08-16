  METHOD update_class_text.
    DATA: lt_classtext TYPE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classtext.
    APPEND is_classtext TO lt_classtext.
    DATA(lv_batch_request_class) = th_mmim_odata_request_builder=>start_request(
        )->open_batch_request(
          )->open_changeset(
            )->open_change(
              )->set_http_operation( 'PUT'
              )->set_uri( iv_uri = 'A_ClfnClassTextForKeyDate(ClassInternalID=' && '''' && is_classtext-classinternalid && '''' && ',' &&
                                                                'LongTextID=' && ''''   && is_classtext-longtextid && '''' && ',' &&
                                                                'Language=' && ''''     && is_classtext-language &&'''' && ')'
              )->set_body( iv_body = me->get_body(
                   it_classtext  = lt_classtext
                   it_fieldname     = VALUE #( ( 'ClassText' ) ) )
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