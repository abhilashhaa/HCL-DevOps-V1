  METHOD create_charc_complete.

*--------------------------------------------------------------------*
* Create characteristic with description using deep insert
*--------------------------------------------------------------------*

    DATA(lv_charcinternalid) = me->create_characteristic(
      is_charc     = ms_chr_multiple
      it_charcdesc = VALUE #(
        ( ms_chr_desc_en ) ) ).

    DATA(ls_desc_de) = ms_chr_desc_de.
    ls_desc_de-charcinternalid = lv_charcinternalid.
    me->create_characteristicdesc(
      is_charcdesc  = ls_desc_de
      iv_navigation = abap_false ).

    DATA(ls_reference) = ms_chr_ref.
    ls_reference-charcinternalid = lv_charcinternalid.
    me->create_characteristicrstrcn( ls_reference ).

    DATA(ls_rstrcn) = ms_chr_rstrcn.
    ls_rstrcn-charcinternalid = lv_charcinternalid.
    me->create_characteristicref( ls_rstrcn ).

    " TODO: Add value and value description

    ms_chr_multiple-charcinternalid = lv_charcinternalid.
    me->validate_result(
      is_charc          = ms_chr_multiple
      it_charc_desc     = VALUE #( ( ms_chr_desc_en ) ( ms_chr_desc_de ) )
      it_charc_ref      = VALUE #( ( ms_chr_ref ) )
      it_charc_rstrcn   = VALUE #( ( ms_chr_rstrcn ) ) ).

  ENDMETHOD.