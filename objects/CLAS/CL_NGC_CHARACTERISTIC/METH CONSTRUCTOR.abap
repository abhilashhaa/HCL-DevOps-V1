METHOD constructor.

  ms_characteristic_header = is_characteristic_header.
  mt_characteristic_ref    = it_characteristic_ref.

  mo_chr_persistency = cl_ngc_core_factory=>get_chr_persistency( ).

  IF it_characteristic_value IS SUPPLIED.
    mt_domain_value = it_characteristic_value.
    mv_domain_values_populated = abap_true.
  ENDIF.

ENDMETHOD.