  METHOD create.

    DATA lo_page TYPE REF TO zcl_abapgit_gui_page_hoc.

    CREATE OBJECT lo_page.
    lo_page->ms_control-page_title = iv_page_title.
    lo_page->ms_control-page_menu  = io_page_menu.
    lo_page->mi_child = ii_child_component.

    ri_page_wrap = lo_page.

  ENDMETHOD.