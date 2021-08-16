  METHOD zif_abapgit_gui_services~get_current_page_name.

    IF mi_cur_page IS BOUND.
      rv_page_name = cl_abap_classdescr=>describe_by_object_ref( mi_cur_page )->get_relative_name( ).
    ENDIF." ELSE - return is empty => initial page

  ENDMETHOD.