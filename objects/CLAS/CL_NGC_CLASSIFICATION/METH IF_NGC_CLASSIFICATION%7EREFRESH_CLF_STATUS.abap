  METHOD if_ngc_classification~refresh_clf_status.

    CLEAR: eo_clf_api_result.

    mo_clf_status->refresh_status(
      EXPORTING
        io_classification = me
      IMPORTING
        eo_clf_api_result = eo_clf_api_result ).

    CLEAR: mt_classtype.

    me->if_ngc_classification~get_assigned_classes(
      IMPORTING
        et_classification_data = DATA(lt_classification_data) ).

    " Set classtype classification statuses
    LOOP AT lt_classification_data ASSIGNING FIELD-SYMBOL(<ls_classification_data>).
      READ TABLE mt_classtype
        TRANSPORTING NO FIELDS
        WITH KEY
          classtype = <ls_classification_data>-classtype.

      IF sy-subrc <> 0.
        mo_clf_status->get_classtype_status(
          EXPORTING
            iv_classtype      = <ls_classification_data>-classtype
            io_classification = me
          IMPORTING
            ev_inconsistent   = DATA(lv_inconsistent)
            ev_released       = DATA(lv_released) ).

        APPEND VALUE #(
            classtype      = <ls_classification_data>-classtype
            isreleased     = lv_released
            isinconsistent = lv_inconsistent )
          TO mt_classtype.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.