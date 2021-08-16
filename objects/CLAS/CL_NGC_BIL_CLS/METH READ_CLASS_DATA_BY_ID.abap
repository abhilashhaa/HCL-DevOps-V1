  METHOD read_class_data_by_id.

    CLEAR: es_class, et_classdesc, et_classkeyword, et_classtext, et_classcharc.

    es_class        = me->single_class_by_int_id( iv_classinternalid ).

    et_classdesc    = me->classdesc_by_int_id( iv_classinternalid ).

    et_classkeyword = me->classkeyword_by_int_id( iv_classinternalid ).

    et_classtext    = me->classtext_by_int_id( iv_classinternalid ).

    et_classcharc   = me->classcharc_by_int_id( iv_classinternalid  ).

  ENDMETHOD.