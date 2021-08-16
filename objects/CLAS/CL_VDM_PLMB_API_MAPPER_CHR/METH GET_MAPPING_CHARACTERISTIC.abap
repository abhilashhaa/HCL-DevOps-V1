  METHOD get_mapping_characteristic.

    INSERT VALUE #(
      vdm_name = 'CHARACTERISTIC'
      api_name = 'CHARACT_NAME' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCDATATYPE'
      api_name = 'DATA_TYPE' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCLENGTH'
      api_name = 'LENGTH' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCGROUP'
      api_name = 'CHARACT_GROUP' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'ADDITIONALVALUEISALLOWED'
      api_name = 'ADDITIONAL_VALUES' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'ENTRYISREQUIRED'
      api_name = 'ENTRY_REQUIRED' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCMAINTAUTHGRP'
      api_name = 'AUTHORITY_GROUP' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'VALUEISCASESENSITIVE'
      api_name = 'CASE_SENSITIV' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CURRENCY'
      api_name = 'CURRENCY' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCDECIMALS'
      api_name = 'DECIMALS' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCVALUEUNIT'
      api_name = 'UNIT_OF_MEASUREMENT' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'NEGATIVEVALUEISALLOWED'
      api_name = 'WITH_SIGN' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCTEMPLATE'
      api_name = 'TEMPLATE' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCEXPONENTVALUE'
      api_name = 'EXPONENT' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCEXPONENTFORMAT'
      api_name = 'EXPONENT_TYPE' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'VALUEINTERVALISALLOWED'
      api_name = 'INTERVAL_ALLOWED' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCISREADONLY'
      api_name = 'NO_ENTRY' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCISHIDDEN'
      api_name = 'NO_DISPLAY' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCENTRYISNOTFORMATCTRLD'
      api_name = 'UNFORMATED' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCTEMPLATEISDISPLAYED'
      api_name = 'SHOW_TEMPLATE' ) INTO TABLE et_field_mapping.

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
      vdm_name = 'CHARCSTATUS'
      api_name = 'STATUS' ) INTO TABLE et_field_mapping.

  ENDMETHOD.