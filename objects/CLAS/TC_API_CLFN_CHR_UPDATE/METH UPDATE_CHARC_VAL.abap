  METHOD update_charc_val.

    DATA(ls_charc_val) = ms_chr_val_char.
    ls_charc_val-charcinternalid = ms_chr_multiple-charcinternalid.
    ls_charc_val-charcvalue = 'VALUE UPD'.

    me->update_characteristicval( ls_charc_val ).

    me->validate_result(
      is_charc          = ms_chr_multiple
      it_charc_desc     = VALUE #( ( ms_chr_desc_en ) ( ms_chr_desc_de ) )
      it_charc_ref      = VALUE #( ( ms_chr_ref ) )
      it_charc_rstrcn   = VALUE #( ( ms_chr_rstrcn ) )
      it_charc_val      = VALUE #( ( ls_charc_val ) )
      it_charc_val_desc = VALUE #( ( ms_chr_val_desc_en ) ) ).

  ENDMETHOD.