  METHOD if_ngc_classification~get_reference_data.

    rr_data = VALUE #( mt_reference_data[ charcreferencetable = iv_charcreferencetable ]-data OPTIONAL ).

  ENDMETHOD.