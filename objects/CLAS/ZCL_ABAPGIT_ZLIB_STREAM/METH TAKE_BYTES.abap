  METHOD take_bytes.

    rv_bytes = mv_compressed(iv_length).
    mv_compressed = mv_compressed+iv_length.

  ENDMETHOD.