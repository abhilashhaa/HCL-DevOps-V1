  METHOD _raise_pragma_enqueue.
    zcx_abapgit_exception=>raise( |Pragma { ms_item-obj_name } enqueue error| ).
  ENDMETHOD.