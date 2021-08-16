  METHOD get_mapping_charcval_desc.

    INSERT VALUE #(
      vdm_name = 'CHARCVALUEDESCRIPTION'
      api_name = 'DESCRIPTION' ) INTO TABLE et_field_mapping.

  ENDMETHOD.