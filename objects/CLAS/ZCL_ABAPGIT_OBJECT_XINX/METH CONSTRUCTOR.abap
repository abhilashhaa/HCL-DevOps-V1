  METHOD constructor.

    super->constructor( is_item     = is_item
                        iv_language = iv_language ).

    cl_wb_object_type=>get_key_components_from_id(
      EXPORTING
        p_key                   = |{ ms_item-obj_name }|
        p_external_id           = swbm_c_type_ddic_db_tabxinx
      IMPORTING
        p_key_component1        = mv_name
        p_key_component2        = mv_id
      EXCEPTIONS
        too_many_key_components = 1
        objecttype_not_existing = 2
        OTHERS                  = 3 ).

    ASSERT sy-subrc = 0.

  ENDMETHOD.