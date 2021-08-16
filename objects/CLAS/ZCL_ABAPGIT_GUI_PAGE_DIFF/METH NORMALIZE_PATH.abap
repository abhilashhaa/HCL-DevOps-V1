  METHOD normalize_path.

    rv_normalized = replace( val  = iv_path
                             sub  = '/'
                             occ  = 0
                             with = '_' ).

  ENDMETHOD.