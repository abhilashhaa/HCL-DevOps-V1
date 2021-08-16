  METHOD zif_abapgit_object~deserialize.

    DATA: ls_task       TYPE lif_task_definition=>ty_task_data,
          lv_xml_string TYPE xstring,
          li_task       TYPE REF TO lif_task_definition.

    io_xml->read( EXPORTING iv_name = 'PDTS'
      CHANGING cg_data = ls_task ).

    li_task = lcl_task_definition=>create(
                      iv_objid     = mv_objid
                      is_task_data = ls_task ).

    li_task->create_task( ).
    li_task->change_wi_text( ).
    li_task->change_method( ).

    lv_xml_string = extract_container( io_xml ).
    li_task->import_container( lv_xml_string ).

    li_task->change_start_events( ).
    li_task->change_terminating_events( ).
    li_task->change_text( ).

    li_task->save( iv_package ).

    tadir_insert( iv_package ).

  ENDMETHOD.