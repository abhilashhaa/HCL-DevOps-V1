  METHOD create_charc_with_desc_deep.

*--------------------------------------------------------------------*
* Create characteristic with description using deep insert
*--------------------------------------------------------------------*

    DATA(lv_charcinternalid) = me->create_characteristic(
      is_charc     = ms_chr_multiple
      it_charcdesc = VALUE #(
        ( ms_chr_desc_en ) ) ).


    ms_chr_multiple-charcinternalid = lv_charcinternalid.
    me->validate_result(
      is_charc = ms_chr_multiple
      it_charc_desc = VALUE #( ( ms_chr_desc_en ) ) ).

  ENDMETHOD.