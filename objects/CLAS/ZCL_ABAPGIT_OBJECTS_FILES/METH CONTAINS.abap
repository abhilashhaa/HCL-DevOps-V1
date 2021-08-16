  METHOD contains.
    DATA: lv_filename TYPE string.

    lv_filename = filename( iv_extra = iv_extra
                            iv_ext   = iv_ext ).

    IF mv_path IS NOT INITIAL.
      READ TABLE mt_files TRANSPORTING NO FIELDS WITH KEY path     = mv_path
                                                          filename = lv_filename.
    ELSE.
      READ TABLE mt_files TRANSPORTING NO FIELDS WITH KEY filename = lv_filename.
    ENDIF.

    IF sy-subrc = 0.
      rv_present = abap_true.
    ENDIF.
  ENDMETHOD.