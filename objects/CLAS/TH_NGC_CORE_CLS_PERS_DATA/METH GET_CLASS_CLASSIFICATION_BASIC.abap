  METHOD get_class_classification_basic.

    rt_class = VALUE #(
      ( clfnobjectid      = cv_class_01_id
        classinternalid   = cv_class_02_id
        validitystartdate = cv_keydate_2017
        validityenddate   = cv_keydate_2018 ) ).

  ENDMETHOD.