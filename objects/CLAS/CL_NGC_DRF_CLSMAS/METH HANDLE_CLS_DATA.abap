METHOD HANDLE_CLS_DATA.

  DELETE ct_cls_key FROM iv_packet_size + 1.

  LOOP AT ct_cls_key ASSIGNING FIELD-SYMBOL(<ls_cls_key>).
    DELETE mt_cls_key WHERE class = <ls_cls_key>-class AND klart = <ls_cls_key>-klart.
  ENDLOOP.

ENDMETHOD.