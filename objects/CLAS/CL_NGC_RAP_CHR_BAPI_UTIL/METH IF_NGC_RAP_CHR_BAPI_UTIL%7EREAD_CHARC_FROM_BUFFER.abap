  METHOD if_ngc_rap_chr_bapi_util~read_charc_from_buffer.

    CALL FUNCTION 'CTMV_GET_CHANGED_CHARS'
      TABLES
        characteristics = rt_cabn.

    SORT rt_cabn DESCENDING BY atnam atinn.
    DELETE ADJACENT DUPLICATES FROM rt_cabn COMPARING atnam.

  ENDMETHOD.