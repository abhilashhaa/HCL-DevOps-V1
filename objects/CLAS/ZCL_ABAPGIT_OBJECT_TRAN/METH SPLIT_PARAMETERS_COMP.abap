  METHOD split_parameters_comp.
    DATA: lv_off TYPE i.

    IF ig_param CS ig_type.
      lv_off = sy-fdpos + strlen( ig_type ).
      cg_value = ig_param+lv_off.
      IF cg_value CA '\'.
        CLEAR cg_value+sy-fdpos.
      ENDIF.
    ENDIF.
  ENDMETHOD.