  METHOD get_mapping_charcdesc.

    INSERT VALUE #(
      vdm_name = 'LANGUAGE'
      api_name = 'LANGUAGE_INT' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CHARCDESCRIPTION'
      api_name = 'DESCRIPTION' ) INTO TABLE et_field_mapping.

  ENDMETHOD.