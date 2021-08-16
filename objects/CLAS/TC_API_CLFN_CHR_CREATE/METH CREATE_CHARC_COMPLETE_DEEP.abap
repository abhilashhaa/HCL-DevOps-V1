  METHOD create_charc_complete_deep.

*--------------------------------------------------------------------*
* Create characteristic with description using deep insert
*--------------------------------------------------------------------*

    DATA(lv_charcinternalid) = me->create_characteristic(
      is_charc          = ms_chr_multiple
      it_charcdesc      = VALUE #( ( ms_chr_desc_en ) )
      it_charcref       = VALUE #( ( ms_chr_ref ) )
      it_charcrstrcn    = VALUE #( ( ms_chr_rstrcn ) )
      it_charcvalue     = VALUE #( ( ms_chr_val_char ) )
      it_charcvaluedesc = VALUE #( ( ms_chr_val_desc_en ) ) ).

    ms_chr_multiple-charcinternalid = lv_charcinternalid.
    me->validate_result(
      is_charc          = ms_chr_multiple
      it_charc_desc     = VALUE #( ( ms_chr_desc_en ) )
      it_charc_ref      = VALUE #( ( ms_chr_ref ) )
      it_charc_rstrcn   = VALUE #( ( ms_chr_rstrcn ) )
      it_charc_val      = VALUE #( ( ms_chr_val_char ) )
      it_charc_val_desc = VALUE #( ( ms_chr_val_desc_en ) ) ).

  ENDMETHOD.