  METHOD delete_charc_ref.

    me->delete_characteristicref(
      iv_charcinternalid = ms_chr_multiple-charcinternalid
      iv_referencetable  = ms_chr_ref-charcreferencetable
      iv_referencefield  = ms_chr_ref-charcreferencetablefield ).

    me->validate_result(
      is_charc          = ms_chr_multiple
      it_charc_desc     = VALUE #( ( ms_chr_desc_en ) ( ms_chr_desc_de ) )
      it_charc_rstrcn   = VALUE #( ( ms_chr_rstrcn ) )
      it_charc_val      = VALUE #( ( ms_chr_val_char ) )
      it_charc_val_desc = VALUE #( ( ms_chr_val_desc_en ) ) ).

  ENDMETHOD.