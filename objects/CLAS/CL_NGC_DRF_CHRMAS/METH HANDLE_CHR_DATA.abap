METHOD HANDLE_CHR_DATA.

  DELETE ct_chr_key FROM iv_packet_size + 1.

  LOOP AT ct_chr_key ASSIGNING FIELD-SYMBOL(<ls_chr_key>).
    DELETE mt_chr_key WHERE atnam = <ls_chr_key>-atnam.
  ENDLOOP.

ENDMETHOD.