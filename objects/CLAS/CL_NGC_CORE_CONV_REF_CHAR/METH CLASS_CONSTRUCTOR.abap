METHOD class_constructor.

  " Prepare the view names for this client.
  gv_nodes_name    = gc_nodes_name    && sy-mandt.
  gv_refchars_name = gc_refchars_name && sy-mandt.
  gv_refkssk_name  = gc_refkssk_name  && sy-mandt.
  gv_refbo_name    = gc_refbo_name    && sy-mandt.
  gv_refbou_name   = gc_refbou_name   && sy-mandt.
  gv_siblchrs_name = gc_siblchrs_name && sy-mandt.

ENDMETHOD.