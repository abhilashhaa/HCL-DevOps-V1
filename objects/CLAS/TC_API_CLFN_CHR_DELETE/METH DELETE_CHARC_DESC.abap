  METHOD delete_charc_desc.

    me->delete_characteristicdesc(
      iv_charcinternalid = ms_chr_multiple-charcinternalid
      iv_language        = ms_chr_desc_de-language ).

    me->validate_result(
      is_charc          = ms_chr_multiple
      it_charc_desc     = VALUE #( ( ms_chr_desc_en ) )
      it_charc_ref      = VALUE #( ( ms_chr_ref ) )
      it_charc_rstrcn   = VALUE #( ( ms_chr_rstrcn ) )
      it_charc_val      = VALUE #( ( ms_chr_val_char ) )
      it_charc_val_desc = VALUE #( ( ms_chr_val_desc_en ) ) ).

  ENDMETHOD.