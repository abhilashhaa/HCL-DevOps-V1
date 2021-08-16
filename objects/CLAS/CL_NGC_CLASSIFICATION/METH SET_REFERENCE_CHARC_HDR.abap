  METHOD set_reference_charc_hdr.

    " set read only field to prevent the modification of the value of
    " the reference characteristic

    mo_chr_persistency->read_by_internal_key(
      EXPORTING
        it_key                      = VALUE #( ( charcinternalid = cs_characteristic_header-charcinternalid
                                                 key_date        = cs_characteristic_header-key_date ) )
      IMPORTING
        et_characteristic_reference = DATA(lt_charc_ref) ).

    LOOP AT lt_charc_ref ASSIGNING FIELD-SYMBOL(<ls_charc_ref>).
      CHECK line_exists( mt_reference_data[ charcreferencetable = <ls_charc_ref>-charcreferencetable ] ).

      cs_characteristic_header-charcisreadonly = abap_true.
      EXIT.
    ENDLOOP.

  ENDMETHOD.