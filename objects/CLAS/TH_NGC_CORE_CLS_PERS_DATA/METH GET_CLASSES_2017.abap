  METHOD get_classes_2017.

    rt_class = VALUE #(
      ( class           = 'TEST_CLASS_EMPTY'
        classinternalid = cv_class_01_id
        classtype       = cv_classtype_001
        classstatus     = 1 )
      ( class           = cv_class_name
        classinternalid = cv_class_02_id
        classtype       = cv_classtype_001
        classstatus     = 1 ) ).

  ENDMETHOD.