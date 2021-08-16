  METHOD GET_EPSILON.

    CONSTANTS: cv_epsilon TYPE f VALUE '1.0E-15'.

    DATA lv_charcvalue TYPE atwrt.

    rv_epsilon = cv_epsilon.

    lv_charcvalue = iv_numvalue.
    SHIFT lv_charcvalue UP TO 'E'.
    SHIFT lv_charcvalue RIGHT.

    lv_charcvalue(1) = '1'.
    rv_epsilon = rv_epsilon * lv_charcvalue.

  ENDMETHOD.