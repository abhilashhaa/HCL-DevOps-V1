  METHOD parse_post_form_data.

    DATA lv_serialized_post_data TYPE string.

    lv_serialized_post_data = translate_postdata( it_post_data ).
    IF iv_upper_cased = abap_true.
      rt_fields = parse_fields_upper_case_name( lv_serialized_post_data ).
    ELSE.
      rt_fields = parse_fields( lv_serialized_post_data ).
    ENDIF.

  ENDMETHOD.