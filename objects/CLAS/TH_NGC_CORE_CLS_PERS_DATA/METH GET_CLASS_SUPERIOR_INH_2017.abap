  METHOD get_class_superior_inh_2017.

    rt_class_superior = VALUE #(
      ( classinternalid         = cv_class_02_id
        ancestorclassinternalid = cv_class_02_id
        classtype               = cv_classtype_001
        class                   = cv_class_name
        ancestorclass           = cv_class_name
        classclassfctnauthgrp   = space )
      ( classinternalid         = cv_class_01_id
        ancestorclassinternalid = cv_class_02_id
        classtype               = cv_classtype_001
        class                   = 'TEST_CLASS_EMPTY'
        ancestorclass           = cv_class_02_id
        classclassfctnauthgrp   = space )
    ).

  ENDMETHOD.