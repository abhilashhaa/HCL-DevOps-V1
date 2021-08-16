  METHOD lock.

    DATA:
      lv_msgv1   TYPE symsgv,
      lv_enqmode TYPE enqmode.

    ASSERT iv_classtype    IS NOT INITIAL
*     AND iv_class        IS NOT INITIAL
       AND iv_clfnobjectid IS NOT INITIAL.

    CLEAR: es_message.

    lv_enqmode = COND #(
      WHEN iv_write = abap_false THEN if_ngc_core_c=>gc_enqmode-shared
      ELSE if_ngc_core_c=>gc_enqmode-exclusive
    ).

    IF line_exists( mt_enqueue_log[ objek = iv_clfnobjectid class = iv_class klart = iv_classtype ] ).
      RETURN.
    ENDIF.

    mo_locking->clen_enqueue_classification(
      EXPORTING
        iv_enqmode = lv_enqmode
        iv_klart   = iv_classtype
        iv_class   = iv_class
        iv_mafid   = if_ngc_core_c=>gc_clf_object_class_indicator-object
        iv_objek   = iv_clfnobjectid
      IMPORTING
        ev_subrc   = DATA(lv_subrc)
    ).

    IF lv_subrc IS INITIAL.
      INSERT VALUE #(
        objek   = iv_clfnobjectid
        class   = iv_class
        klart   = iv_classtype
        enqmode = lv_enqmode
        mafid   = 'O' ) INTO TABLE mt_enqueue_log.
    ELSE.
      CASE lv_subrc.
        WHEN 1.
          IF sy-msgv1 IS INITIAL.
            MESSAGE e517(cl) INTO DATA(lv_msg) ##NEEDED. " Classification not possible at the moment
          ELSE.
            lv_msgv1 = sy-msgv1.
            MESSAGE e518(cl) WITH iv_classtype iv_class lv_msgv1 INTO lv_msg ##NEEDED. " Class type & : class & locked by user &
          ENDIF.
        WHEN 2.
          MESSAGE e519(cl) INTO lv_msg. " Locking errors
      ENDCASE.

      es_message-msgid = sy-msgid.
      es_message-msgty = sy-msgty.
      es_message-msgno = sy-msgno.
      es_message-msgv1 = sy-msgv1.
      es_message-msgv2 = sy-msgv2.
      es_message-msgv3 = sy-msgv3.
      es_message-msgv4 = sy-msgv4.
    ENDIF.

  ENDMETHOD.