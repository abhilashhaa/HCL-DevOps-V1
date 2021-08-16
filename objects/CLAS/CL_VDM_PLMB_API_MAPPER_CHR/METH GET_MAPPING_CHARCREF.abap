  METHOD get_mapping_charcref.

    INSERT VALUE #(
      vdm_name = 'CHARCREFERENCETABLE'
      api_name = 'REFERENCE_TABLE' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCREFERENCETABLEFIELD'
      api_name = 'REFERENCE_FIELD' ) INTO TABLE et_field_mapping.

  ENDMETHOD.