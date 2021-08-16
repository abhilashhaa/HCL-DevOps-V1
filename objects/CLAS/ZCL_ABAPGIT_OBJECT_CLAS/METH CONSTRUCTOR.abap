  METHOD constructor.
    super->constructor( is_item     = is_item
                        iv_language = iv_language ).

    CREATE OBJECT mi_object_oriented_object_fct TYPE zcl_abapgit_oo_class.

    mv_classpool_name = cl_oo_classname_service=>get_classpool_name( |{ is_item-obj_name }| ).

  ENDMETHOD.