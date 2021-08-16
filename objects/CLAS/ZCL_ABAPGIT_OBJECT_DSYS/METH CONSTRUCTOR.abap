  METHOD constructor.

    DATA: lv_prefix    TYPE namespace,
          lv_bare_name TYPE progname.

    super->constructor( is_item = is_item
                        iv_language = iv_language ).

    IF ms_item-obj_name(1) = '/'.
      CALL FUNCTION 'RS_NAME_SPLIT_NAMESPACE'
        EXPORTING
          name_with_namespace    = ms_item-obj_name
        IMPORTING
          namespace              = lv_prefix
          name_without_namespace = lv_bare_name.
    ELSE.
      lv_bare_name = ms_item-obj_name.
    ENDIF.

    mv_doc_object = |{ lv_bare_name+0(4) }{ lv_prefix }{ lv_bare_name+4(*) }|.

  ENDMETHOD.