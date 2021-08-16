METHOD constructor.

  mv_appl_name            = iv_appl_name.
  mv_class_type           = iv_class_type.
  mv_customizing_handling = iv_customizing_handling.

  " Prepare the view names for this client
  mv_kssku_name = gc_kssku_name && sy-mandt.
  mv_auspu_name = gc_auspu_name && sy-mandt.

ENDMETHOD.