  METHOD get_class_charcs_overwr_2017.

    rt_class_charc = VALUE #(
      ( classinternalid            = cv_class_02_id
        ancestorclassinternalid    = cv_class_02_id
        class                      = cv_class_name
        classtype                  = cv_classtype_001
        characteristic             = 'CHARACTERISTIC_OVERWRITE'
        charcinternalid            = cv_charc_02_id
        overwrittencharcinternalid = cv_charc_overwritten_id
        charcpositionnumber        = '1' ) ).

  ENDMETHOD.