  METHOD _raise_pragma_exists.
    zcx_abapgit_exception=>raise( |Pragma { ms_item-obj_name } exists| ).
  ENDMETHOD.