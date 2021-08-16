METHOD IF_DRF_OUTBOUND~READ_COMPLETE_DATA.

  DATA: lt_relevant_objects TYPE ngct_drf_chrmas_object_key.

  lt_relevant_objects = ct_relevant_objects.

  LOOP AT lt_relevant_objects ASSIGNING FIELD-SYMBOL(<ls_relevant_object>).

    APPEND VALUE #( atnam = <ls_relevant_object>-atnam ) TO mt_chr_key.

  ENDLOOP.

ENDMETHOD.