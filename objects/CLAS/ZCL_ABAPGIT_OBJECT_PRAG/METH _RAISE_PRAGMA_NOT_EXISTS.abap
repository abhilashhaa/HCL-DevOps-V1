  METHOD _raise_pragma_not_exists.
    zcx_abapgit_exception=>raise( |Pragma { ms_item-obj_name } doesn't exist| ).
  ENDMETHOD.