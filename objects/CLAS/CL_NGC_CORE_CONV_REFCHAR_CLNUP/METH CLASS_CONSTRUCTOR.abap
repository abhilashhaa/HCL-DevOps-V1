  METHOD class_constructor.

    " Prepare the view names for this client.
    gv_refchars_name = gc_refchars_name && sy-mandt.
    gv_nodes_name    = gc_nodes_name && sy-mandt.

  ENDMETHOD.