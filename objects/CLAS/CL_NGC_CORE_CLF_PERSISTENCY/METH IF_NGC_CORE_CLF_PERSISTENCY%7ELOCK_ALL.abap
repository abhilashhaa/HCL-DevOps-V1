  METHOD if_ngc_core_clf_persistency~lock_all.

    DATA:
      ls_message TYPE ngcs_core_classification_msg.

    CLEAR: et_message.

    LOOP AT it_classification_key ASSIGNING FIELD-SYMBOL(<ls_classification_key>).

      LOOP AT mt_kssk_changes ASSIGNING FIELD-SYMBOL(<ls_kssk_changes>)
        WHERE
          object_key = <ls_classification_key>-object_key AND
          technical_object = <ls_classification_key>-technical_object.

        DATA(ls_class) = VALUE #( mt_classes[ classinternalid = <ls_kssk_changes>-classinternalid ] OPTIONAL ).

        ASSERT FIELDS 'Class should be loaded at this point' CONDITION ls_class IS NOT INITIAL.

        IF NOT line_exists(
          mt_enqueue_log[
            objek   = <ls_classification_key>-object_key
            class   = ls_class-class
            klart   = <ls_kssk_changes>-classtype
            enqmode = 'E'
            mafid   = 'O' ] ).
          mo_locking->clen_enqueue_classification(
            EXPORTING
              iv_enqmode = 'E'
              iv_mafid   = 'O'
              iv_klart   = <ls_kssk_changes>-classtype
              iv_objek   = <ls_kssk_changes>-object_key
              iv_class   = ls_class-class
            IMPORTING
              ev_subrc = DATA(subrc) ).

          IF subrc = 0.
            INSERT VALUE #(
              objek   = <ls_classification_key>-object_key
              class   = ls_class-class
              klart   = <ls_kssk_changes>-classtype
              enqmode = 'E'
              mafid   = 'O' ) INTO TABLE mt_enqueue_log.
          ELSE.
            MOVE-CORRESPONDING <ls_classification_key> TO ls_message.
            MOVE-CORRESPONDING sy TO ls_message.
            APPEND ls_message TO et_message.
            CLEAR: ls_message.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    SORT et_message BY object_key technical_object.
    DELETE ADJACENT DUPLICATES FROM et_message.

  ENDMETHOD.