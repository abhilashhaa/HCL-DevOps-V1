  METHOD constructor.

    super->constructor( ).

    mo_chr_bapi_util = NEW cl_ngc_rap_chr_bapi_util( ).


    ms_chr_multiple = VALUE #(
      characteristic = 'CHR_API_MULTIPLE'
      charcdatatype  = 'CHAR'
      charclength    = '12'
      charcstatus    = '1' ).

    ms_chr_desc_en = VALUE #(
      charcdescription = 'Desc EN'
      language         = 'EN' ).

    ms_chr_desc_de = VALUE #(
      charcdescription = 'Desc DE'
      language         = 'DE' ).

    ms_chr_ref = VALUE #(
      charcreferencetable      = 'MARA'
      charcreferencetablefield = 'ERNAM' ).

    ms_chr_rstrcn = VALUE #(
      classtype = '001' ).

    ms_chr_val_char = VALUE #(
      charcvalue               = 'VALUE01'
      charcvaluedependency     = '1'
      charcvaluepositionnumber = '1' ).

    ms_chr_val_desc_en = VALUE #(
      language                 = 'EN'
      charcvaluedescription    = 'Value Desc EN' ).

  ENDMETHOD.