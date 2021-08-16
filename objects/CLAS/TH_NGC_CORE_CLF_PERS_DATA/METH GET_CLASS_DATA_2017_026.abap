  METHOD GET_CLASS_DATA_2017_026.

    rt_class_data = VALUE #(
      ( classinternalid = cv_class_01_id
        class           = 'CLASS_01'
        classtype       = cv_classtype_026
        classisusableinbom = abap_true
        key_date        = cv_keydate_2017 )
      ( classinternalid = cv_class_02_id
        class           = 'CLASS_02'
        classisusableinbom = abap_true
        classtype       = cv_classtype_026
        key_date        = cv_keydate_2017 ) ).

  ENDMETHOD.