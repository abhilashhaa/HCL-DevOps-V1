  METHOD get_mapping_classdesc.

    INSERT VALUE #(
      vdm_name = 'LANGUAGE'
      api_name = 'LANGU' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CLASSDESCRIPTION'
      api_name = 'CATCHWORD' ) INTO TABLE et_field_mapping.

  ENDMETHOD.