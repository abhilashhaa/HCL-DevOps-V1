  METHOD create_class_charc_in_batch.
    " prepared to work with 2 entries in IT_CLASSCHARC only
    CHECK lines( it_classcharc ) EQ 2.
    " based on entries, it is using either the charcinternalid or the characteristic
    DATA(lv_batch_request_class) = th_mmim_odata_request_builder=>start_request(
      )->open_batch_request(
        )->open_changeset(
          )->open_change( )->set_http_operation( 'POST'
            )->set_uri( iv_uri = 'A_ClfnClassForKeyDate(ClassInternalID=' && '''' && is_class-classinternalid && '''' && ')' && '/to_ClassCharacteristic'
              )->set_body( iv_body = me->get_body(
                   it_classcharc = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classcharc( ( it_classcharc[ 1 ] ) )" it_classcharc
                   it_fieldname  = COND #(  WHEN it_classcharc[ 1 ]-characteristic IS INITIAL
                                            THEN VALUE #( ( 'CharcInternalID' ) )
                                            ELSE VALUE #( ( 'Characteristic' ) ) ) )
          )->open_change( )->set_http_operation( 'POST'
            )->set_uri( iv_uri = 'A_ClfnClassForKeyDate(ClassInternalID=' && '''' && is_class-classinternalid && '''' && ')' && '/to_ClassCharacteristic'
              )->set_body( iv_body = me->get_body(
                   it_classcharc = VALUE cl_ngc_bil_cls=>lty_clfn_class_cds-t_classcharc( ( it_classcharc[ 2 ] ) )
                   it_fieldname  = COND #(  WHEN it_classcharc[ 2 ]-characteristic IS INITIAL
                                            THEN VALUE #( ( 'CharcInternalID' ) )
                                            ELSE VALUE #( ( 'Characteristic' ) ) ) )
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