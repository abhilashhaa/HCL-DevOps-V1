  METHOD setup.

    gv_method_index = gv_method_index + 1.
    ms_chr_multiple-characteristic = |CHR_API_DEL_{ gv_method_index }|.

    mo_chr_bapi_util->create_characteristic(
      is_characteristic_bapi = VALUE #(
        charact_name     = ms_chr_multiple-characteristic
        data_type        = ms_chr_multiple-charcdatatype
        length           = ms_chr_multiple-charclength
        status           = ms_chr_multiple-charcstatus
        value_assignment = COND #( WHEN ms_chr_multiple-multiplevaluesareallowed = abap_true THEN 'M' ELSE 'S' ) )
      it_charcdesc_bapi      = VALUE #(
        ( language_int = ms_chr_desc_en-language
          description  = ms_chr_desc_en-charcdescription )
        ( language_int = ms_chr_desc_de-language
          description  = ms_chr_desc_de-charcdescription ) )
      it_charcref_bapi       = VALUE #(
        ( reference_table = ms_chr_ref-charcreferencetable
          reference_field = ms_chr_ref-charcreferencetablefield ) )
      it_charcrstrcn_bapi    = VALUE #(
        ( class_type = ms_chr_rstrcn-classtype ) )
      it_charcvalchar_bapi   = VALUE #(
        ( value_char = ms_chr_val_char-charcvalue ) ) ).

    DATA(lt_buffer) = mo_chr_bapi_util->read_charc_from_buffer( ).
    DATA(ls_charc) = VALUE #( lt_buffer[ atnam = ms_chr_multiple-characteristic ] OPTIONAL ).

    IF ls_charc IS INITIAL.
      SELECT SINGLE FROM a_clfncharacteristicforkeydate( p_keydate = @sy-datum )
        FIELDS
          charcinternalid
        WHERE
          characteristic = @ms_chr_multiple-characteristic
        INTO @DATA(lv_charcinternalid).
    ELSE.
      lv_charcinternalid = ls_charc-atinn.

      COMMIT WORK AND WAIT.
    ENDIF.

    cl_abap_unit_assert=>assert_not_initial(
      act = lv_charcinternalid
      msg = |Characteristic { ms_chr_multiple-characteristic } should exist in buffer or db| ).

    ms_chr_multiple-charcinternalid = lv_charcinternalid.

    me->validate_result(
      is_charc          = ms_chr_multiple
      it_charc_desc     = VALUE #( ( ms_chr_desc_en ) ( ms_chr_desc_de ) )
      it_charc_ref      = VALUE #( ( ms_chr_ref ) )
      it_charc_rstrcn   = VALUE #( ( ms_chr_rstrcn ) )
      it_charc_val      = VALUE #( ( ms_chr_val_char ) )
      it_charc_val_desc = VALUE #( ( ms_chr_val_desc_en ) ) ).

  ENDMETHOD.