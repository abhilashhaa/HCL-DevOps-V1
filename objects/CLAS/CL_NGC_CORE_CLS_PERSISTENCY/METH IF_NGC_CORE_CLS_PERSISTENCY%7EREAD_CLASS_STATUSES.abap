  METHOD if_ngc_core_cls_persistency~read_class_statuses.

    CLEAR: rt_class_status.

    read_class_status_int( ).

    LOOP AT mt_class_status ASSIGNING FIELD-SYMBOL(<ls_class_status>)
      WHERE classtype = iv_classtype.
      APPEND <ls_class_status> TO rt_class_status.
    ENDLOOP.

  ENDMETHOD.