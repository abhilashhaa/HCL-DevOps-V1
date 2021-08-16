  METHOD zif_abapgit_object~serialize.

    DATA li_task TYPE REF TO lif_task_definition.

    li_task = lcl_task_definition=>load( mv_objid ).
    li_task->clear_origin_data( ).
    io_xml->add( iv_name = 'PDTS'
                 ig_data = li_task->get_definition( ) ).

    io_xml->add_xml( iv_name = 'CONTAINER'
                     ii_xml  = get_container_xml( li_task ) ).

  ENDMETHOD.