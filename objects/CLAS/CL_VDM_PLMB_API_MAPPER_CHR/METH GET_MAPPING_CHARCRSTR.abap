  METHOD get_mapping_charcrstr.

    INSERT VALUE #(
      vdm_name = 'CLASSTYPE'
      api_name = 'CLASS_TYPE' ) INTO TABLE et_field_mapping.

  ENDMETHOD.