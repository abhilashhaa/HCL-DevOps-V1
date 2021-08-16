  METHOD get_mapping_classcharc.

    INSERT VALUE #(
      vdm_name = 'CHARACTERISTIC'
      api_name = 'NAME_CHAR' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCISSEARCHRELEVANT'
      api_name = 'SELECT_RELEV' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCISDISPLAYRELEVANT'
      api_name = 'DISPLAY_RELEV' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCISPRINTRELEVANT'
      api_name = 'PRINT_RELEV' ) INTO TABLE et_field_mapping.

  ENDMETHOD.