  METHOD create_class.
    CLEAR rv_classinternalid.
    DATA(lv_batch_request_class) = th_mmim_odata_request_builder=>start_request(
        )->open_batch_request(
          )->open_changeset(
            )->open_change(
              )->set_http_operation( 'POST'
              )->set_uri( iv_uri = 'A_ClfnClassForKeyDate'
              )->set_body( iv_body = get_body_class(
                   is_class                   = is_class
                   it_class_fieldname         = VALUE #( ( 'Class' ) ( 'ClassType' ) ( 'ClassDescription' ) )
                   it_classdesc               = it_classdesc
                   it_classdesc_fieldname     = VALUE #( ( 'Language' ) ( 'ClassDescription' ) )
                   it_classkeyword            = it_classkeyword
                   it_classkeyword_fieldname  = VALUE #( ( 'Language' ) ( 'ClassKeywordText' ) )
                   it_classtext               = it_classtext
                   it_classtext_fieldname     = VALUE #( ( 'Language' ) ( 'LongTextID' ) ( 'ClassText' ) )
                   it_classcharc              = it_classcharc
                   it_classcharc_fieldname    = VALUE #( ( 'Characteristic' ) )
                 )
          )->close_changeset(
        )->close_batch_request(
        )->close_request( ).
    " execute & check returned status code
    DATA(lv_reponse) = me->posturl(
          iv_uri          = '$batch'
          iv_request      = lv_batch_request_class
          iv_content_type = 'multipart/mixed;boundary=batch_boundary'
          iv_accept       = 'application/json'
          iv_status_code  = '202' ).
    " Get XML data line from response
    DATA: lt_response_line        TYPE TABLE OF string,
          lv_response_line_in_xml TYPE string.
    SPLIT lv_reponse AT cl_abap_char_utilities=>newline INTO TABLE lt_response_line.
    LOOP AT lt_response_line ASSIGNING FIELD-SYMBOL(<ls_response_line>).
      IF NOT <ls_response_line> CP '<?xml*'.
        DELETE lt_response_line.
      ENDIF.
    ENDLOOP.
    READ TABLE lt_response_line INTO lv_response_line_in_xml INDEX 1.
    DATA(lv_classinternalid_as_string) = get_attribtue_value_from_xml(
      EXPORTING
        iv_xml            = lv_response_line_in_xml
        iv_attribute_name = 'ClassInternalID' ).
    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act              = lv_classinternalid_as_string
        msg              = 'Newly created class ID is not returned' ).
    rv_classinternalid = lv_classinternalid_as_string.
  ENDMETHOD.