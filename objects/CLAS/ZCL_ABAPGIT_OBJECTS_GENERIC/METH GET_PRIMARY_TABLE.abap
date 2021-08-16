  METHOD get_primary_table.

    DATA: ls_object_table LIKE LINE OF mt_object_table.


    READ TABLE mt_object_table INTO ls_object_table WITH KEY prim_table = abap_true.
    IF sy-subrc <> 0.
*    Fallback. For some objects, no primary table is explicitly flagged
*    The, the one with only one key field shall be chosen
      READ TABLE mt_object_table INTO ls_object_table WITH KEY tobjkey = '/&'. "#EC CI_SUBRC
    ENDIF.
    IF ls_object_table IS INITIAL.
      zcx_abapgit_exception=>raise( |Object { ms_item-obj_type } has got no defined primary table| ).
    ENDIF.

    rv_table = ls_object_table-tobj_name.

  ENDMETHOD.