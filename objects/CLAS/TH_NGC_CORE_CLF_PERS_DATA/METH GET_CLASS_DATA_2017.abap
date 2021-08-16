  METHOD get_class_data_2017.

    rt_class_data = VALUE #(
      ( classinternalid = cv_class_01_id
        class           = 'CLASS_01'
        classtype       = cv_classtype_001
        classisusableinbom = abap_true
        key_date        = cv_keydate_2017 )
      ( classinternalid = cv_class_02_id
        class           = 'CLASS_02'
        classtype       = cv_classtype_001
        key_date        = cv_keydate_2017 )
      ( classinternalid = cv_class_03_id
        class           = 'CLASS_03'
        classtype       = cv_classtype_001
        key_date        = cv_keydate_2017 )
      ( classinternalid = cv_class_04_id
        class           = 'CLASS_04'
        classtype       = cv_classtype_001
        key_date        = cv_keydate_2017 )
      ( classinternalid = cv_class_new_id
        class           = 'CLASS_NEW'
        classtype       = cv_classtype_001
        key_date        = cv_keydate_2017 ) ).

  ENDMETHOD.