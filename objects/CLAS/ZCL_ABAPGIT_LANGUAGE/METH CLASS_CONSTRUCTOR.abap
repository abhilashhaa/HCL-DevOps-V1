  METHOD class_constructor.

    DATA lv_dummy TYPE string.

    GET LOCALE LANGUAGE gv_login_language COUNTRY lv_dummy MODIFIER lv_dummy.

  ENDMETHOD.