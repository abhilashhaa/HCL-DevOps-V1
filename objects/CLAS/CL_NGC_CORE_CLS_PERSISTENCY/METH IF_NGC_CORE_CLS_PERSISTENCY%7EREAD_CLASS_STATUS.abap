  METHOD if_ngc_core_cls_persistency~read_class_status.

    CLEAR: rs_class_status.

    read_class_status_int( ).

    READ TABLE mt_class_status INTO rs_class_status
      WITH KEY classtype   = iv_classtype
               classstatus = iv_classstatus.

  ENDMETHOD.