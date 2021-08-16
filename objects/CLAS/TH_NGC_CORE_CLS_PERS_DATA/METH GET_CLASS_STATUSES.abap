  METHOD get_class_statuses.

    rt_status = VALUE #(
      ( classtype               = cv_classtype_001
        classificationisallowed = abap_true
        classstatus             = 1 )
      ( classtype               = cv_classtype_001
        classificationisallowed = abap_false
        classstatus             = 2 )
      ( classtype               = cv_classtype_300
        classificationisallowed = abap_true
        classstatus             = 1 )
      ( classtype               = cv_classtype_300
        classificationisallowed = abap_false
        classstatus             = 2 )  ).

  ENDMETHOD.