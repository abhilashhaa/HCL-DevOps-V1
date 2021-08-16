METHOD IF_DRF_OUTBOUND~READ_COMPLETE_DATA.

  DATA: lt_relevant_objects TYPE ngct_drf_clsmas_object_key.

  lt_relevant_objects = ct_relevant_objects.

  LOOP AT lt_relevant_objects ASSIGNING FIELD-SYMBOL(<ls_relevant_object>).

    APPEND VALUE #( class = <ls_relevant_object>-class
                    klart = <ls_relevant_object>-klart ) TO mt_cls_key.

  ENDLOOP.

ENDMETHOD.