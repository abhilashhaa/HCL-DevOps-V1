  METHOD get_mapping_classtext.

    INSERT VALUE #(
      vdm_name = 'LANGUAGE'
      api_name = 'LANGU' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'LONGTEXTID'
      api_name = 'TEXT_TYPE' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CLASSTEXT'
      api_name = 'TEXT_DESCR' ) INTO TABLE et_field_mapping.

  ENDMETHOD.