  METHOD map_api_ext_to_int.

    rs_charc_data-charc = CORRESPONDING #( it_charc[ 1 ] ).
    rs_charc_data-charc-charcinternalid = iv_charcinternalid.
    rs_charc_data-charcval = CORRESPONDING #( it_charc_val ).

  ENDMETHOD.