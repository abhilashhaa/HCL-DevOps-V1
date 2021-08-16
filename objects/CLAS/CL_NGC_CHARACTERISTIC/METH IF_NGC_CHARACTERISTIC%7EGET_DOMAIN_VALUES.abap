METHOD if_ngc_characteristic~get_domain_values.

  DATA lo_chr_api_result TYPE REF TO cl_ngc_chr_api_result.

  lo_chr_api_result = NEW cl_ngc_chr_api_result( ).

  IF mv_domain_values_populated = abap_true.
    et_domain_value = mt_domain_value.
  ELSE.
    mo_chr_persistency->read_by_internal_key(
      EXPORTING
        it_key                  = VALUE #(
          ( charcinternalid            = ms_characteristic_header-charcinternalid
            overwrittencharcinternalid = ms_characteristic_header-overwrittencharcinternalid
            key_date                   = ms_characteristic_header-key_date ) )
      IMPORTING
        et_characteristic_value = DATA(lt_domain_value)
        et_message              = DATA(lt_message) ).

    lo_chr_api_result->add_messages_from_core( lt_message ).

    mt_domain_value = CORRESPONDING #( lt_domain_value ).
    et_domain_value = et_domain_value.

    mv_domain_values_populated = abap_true.
  ENDIF.

  eo_chr_api_result = lo_chr_api_result.

ENDMETHOD.