  METHOD get_class_charcs_2017.

    rt_class_charc = VALUE #(
      ( classinternalid            = cv_class_02_id
        ancestorclassinternalid    = cv_class_02_id
        class                      = cv_class_name
        classtype                  = cv_classtype_001
        characteristic             = 'CHARACTERISTIC_01'
        charcinternalid            = cv_charc_01_id
        charcpositionnumber        = '1' )
      ( classinternalid            = cv_class_02_id
        ancestorclassinternalid    = cv_class_02_id
        class                      = cv_class_name
        classtype                  = cv_classtype_001
        characteristic             = 'CHARACTERISTIC_02'
        charcinternalid            = cv_charc_02_id
        charcpositionnumber        = '2' ) ).

  ENDMETHOD.