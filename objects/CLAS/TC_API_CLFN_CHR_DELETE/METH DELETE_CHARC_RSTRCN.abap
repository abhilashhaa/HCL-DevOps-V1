  METHOD delete_charc_rstrcn.

    me->delete_characteristicrstrcn(
      iv_charcinternalid = ms_chr_multiple-charcinternalid
      iv_classtype       = ms_chr_rstrcn-classtype ).

    me->validate_result(
      is_charc          = ms_chr_multiple
      it_charc_desc     = VALUE #( ( ms_chr_desc_en ) ( ms_chr_desc_de ) )
      it_charc_ref      = VALUE #( ( ms_chr_ref ) )
      it_charc_val      = VALUE #( ( ms_chr_val_char ) )
      it_charc_val_desc = VALUE #( ( ms_chr_val_desc_en ) ) ).

  ENDMETHOD.