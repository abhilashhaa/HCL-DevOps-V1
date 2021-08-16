METHOD create_characteristic.

  ASSERT is_characteristic_header IS NOT INITIAL.

  IF it_characteristic_value IS SUPPLIED AND
     is_characteristic_header-charccheckfunctionmodule IS INITIAL AND
     is_characteristic_header-charcchecktable IS INITIAL.
    ro_characteristic = NEW cl_ngc_characteristic(
                            is_characteristic_header = is_characteristic_header
                            it_characteristic_value  = it_characteristic_value
                            it_characteristic_ref    = it_characteristic_ref ).
  ELSE.
    ro_characteristic = NEW cl_ngc_characteristic(
      is_characteristic_header = is_characteristic_header
      it_characteristic_ref    = it_characteristic_ref ).
  ENDIF.

ENDMETHOD.