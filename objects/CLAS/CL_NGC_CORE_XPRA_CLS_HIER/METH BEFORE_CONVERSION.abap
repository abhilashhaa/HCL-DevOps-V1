METHOD before_conversion.

  " Ensure only privileged user are allowed to manually start the data conversion.
  rv_exit = cl_ngc_core_data_conv=>check_authority( ).

ENDMETHOD.