  METHOD create.

    DATA lo_component TYPE REF TO zcl_abapgit_gui_page_tutorial.

    CREATE OBJECT lo_component.

    ri_page = zcl_abapgit_gui_page_hoc=>create(
      iv_page_title      = 'Tutorial'
      io_page_menu       = build_main_menu( )
      ii_child_component = lo_component ).

  ENDMETHOD.