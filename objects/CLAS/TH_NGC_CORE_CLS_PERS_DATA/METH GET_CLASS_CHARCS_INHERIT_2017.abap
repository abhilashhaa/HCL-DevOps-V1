  METHOD get_class_charcs_inherit_2017.

    rt_class_charc = VALUE #(
      ( classinternalid            = cv_class_02_id
        ancestorclassinternalid    = cv_class_02_id
        class                      = cv_class_name
        classtype                  = cv_classtype_001
        characteristic             = 'CHARACTERISTIC_INHERITED'
        charcinternalid            = cv_charc_02_id
        charcpositionnumber        = '1' )
      ( classinternalid            = cv_class_01_id
        ancestorclassinternalid    = cv_class_02_id
        class                      = 'TEST_CLASS_EMPTY'
        classtype                  = cv_classtype_001
        characteristic             = 'CHARACTERISTIC_INHERITED'
        charcinternalid            = cv_charc_02_id
        charcisinherited           = abap_true
        charcpositionnumber        = '1' ) ).

  ENDMETHOD.