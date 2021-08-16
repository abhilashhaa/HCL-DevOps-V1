METHOD constructor.

  mv_appl_name = iv_appl_name.
  mv_client    = iv_client.

  " Prepare the view names for this client.
  mv_inconinob_name = gc_inconinob_name && mv_client.

ENDMETHOD.