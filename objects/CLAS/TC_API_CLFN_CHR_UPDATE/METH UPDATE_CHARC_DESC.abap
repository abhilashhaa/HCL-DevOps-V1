  METHOD update_charc_desc.

    DATA(ls_charc_desc_upd) = ms_chr_desc_en.
    ls_charc_desc_upd-charcinternalid = ms_chr_multiple-charcinternalid.
    ls_charc_desc_upd-charcdescription = 'Desc UPD'.

    me->update_characteristicdesc( ls_charc_desc_upd ).

    me->validate_result(
      is_charc          = ms_chr_multiple
      it_charc_desc     = VALUE #( ( ls_charc_desc_upd ) ( ms_chr_desc_de ) )
      it_charc_ref      = VALUE #( ( ms_chr_ref ) )
      it_charc_rstrcn   = VALUE #( ( ms_chr_rstrcn ) )
      it_charc_val      = VALUE #( ( ms_chr_val_char ) )
      it_charc_val_desc = VALUE #( ( ms_chr_val_desc_en ) ) ).

  ENDMETHOD.