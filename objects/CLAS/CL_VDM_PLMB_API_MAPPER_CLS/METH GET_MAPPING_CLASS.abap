  METHOD get_mapping_class.

    INSERT VALUE #(
      vdm_name = 'CLASS'
      api_name = 'CLASSNUM' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CLASSTYPE'
      api_name = 'CLASSTYPE' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CLASSMAINTAUTHGRP'
      api_name = 'AUTHMAINTAIN' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CLASSSEARCHAUTHGRP'
      api_name = 'AUTHSEARCH' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CLASSCLASSFCTNAUTHGRP'
      api_name = 'AUTHCLASSIFY' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CLASSGROUP'
      api_name = 'CLASSGROUP' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CLASSISLOCAL'
      api_name = 'LOCAL_CLASS' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'CLASSSTATUS'
      api_name = 'STATUS' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'DOCUMENTINFORECORDDOCNUMBER'
      api_name = 'DOCUMENT_NUMBER' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'DOCUMENTINFORECORDDOCTYPE'
      api_name = 'DOCUMENT_TYPE' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'DOCUMENTINFORECORDDOCPART'
      api_name = 'DOCUMENT_PART' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'DOCUMENTINFORECORDDOCVERSION'
      api_name = 'DOCUMENT_VERSION' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'VALIDITYENDDATE'
      api_name = 'VALID_TO' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'VALIDITYSTARTDATE'
      api_name = 'VALID_FROM' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'STANDARD_NAME'
      api_name = 'CLASSSTANDARDORGNAME' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'STANDARD_NO'
      api_name = 'CLASSSTANDARDNUMBER' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'DATE_OF_ISSUE'
      api_name = 'CLASSSTANDARDSTARTDATE' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'DATE_OF_VERSION'
      api_name = 'CLASSSTANDARDVERSIONSTARTDATE' ) INTO TABLE et_field_mapping.

    INSERT VALUE #(
      vdm_name = 'NO_OF_VERSION'
      api_name = 'CLASSSTANDARDVERSION' ) INTO TABLE et_field_mapping.

  ENDMETHOD.