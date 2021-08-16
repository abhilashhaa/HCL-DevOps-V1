  METHOD get_mapping_charcval.

    INSERT VALUE #(
      vdm_name = 'ISDEFAULTVALUE'
      api_name = 'DEFAULT_VALUE' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCFROMNUMERICVALUE'
      api_name = 'VALUE_FROM' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCTONUMERICVALUE'
      api_name = 'VALUE_TO' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCFROMNUMERICVALUEUNIT'
      api_name = 'UNIT_FROM' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCTONUMERICVALUEUNIT'
      api_name = 'UNIT_TO' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCVALUEDEPENDENCY'
      api_name = 'VALUE_RELATION' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'DOCNUMBER'
      api_name = 'DOCUMENT_NO' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'DOCUMENTPART'
      api_name = 'DOCUMENT_PART' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'DOCUMENTTYPE'
      api_name = 'DOCUMENT_TYPE' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'DOCUMENTVERSION'
      api_name = 'DOCUMENT_VERSION' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCVALUE'
      api_name = 'VALUE_CHAR' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCVALUE'
      api_name = 'VALUE_CHAR_LONG' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCFROMNUMERICVALUEUNIT'
      api_name = 'CURRENCY_FROM' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCTONUMERICVALUEUNIT'
      api_name = 'CURRENY_TO' ) INTO TABLE et_field_mapping.

  ENDMETHOD.