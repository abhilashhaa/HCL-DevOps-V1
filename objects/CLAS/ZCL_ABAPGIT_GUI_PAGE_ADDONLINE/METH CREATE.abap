  METHOD create.

    DATA lo_component TYPE REF TO zcl_abapgit_gui_page_addonline.

    CREATE OBJECT lo_component.

    ri_page = zcl_abapgit_gui_page_hoc=>create(
      iv_page_title = 'Clone online repository'
      ii_child_component = lo_component ).

  ENDMETHOD.