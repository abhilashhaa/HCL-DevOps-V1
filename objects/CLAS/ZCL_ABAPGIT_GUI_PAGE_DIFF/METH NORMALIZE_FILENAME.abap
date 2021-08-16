  METHOD normalize_filename.

    rv_normalized = replace( val  = iv_filename
                             sub  = '.'
                             occ  = 0
                             with = '_' ).

  ENDMETHOD.