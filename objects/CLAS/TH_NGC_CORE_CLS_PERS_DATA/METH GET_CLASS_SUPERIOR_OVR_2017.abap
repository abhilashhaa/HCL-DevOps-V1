  METHOD get_class_superior_ovr_2017.

    rt_class_superior = VALUE #(
      ( classinternalid         = cv_class_02_id
        ancestorclassinternalid = cv_class_02_id
        classtype               = cv_classtype_001
        class                   = cv_class_name
        ancestorclass           = cv_class_name
        classclassfctnauthgrp   = space )
    ).

  ENDMETHOD.