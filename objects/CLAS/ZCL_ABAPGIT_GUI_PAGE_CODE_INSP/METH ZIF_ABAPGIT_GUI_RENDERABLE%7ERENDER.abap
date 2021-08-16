  METHOD zif_abapgit_gui_renderable~render.

    ms_control-page_menu = build_menu( ).
    ri_html = super->zif_abapgit_gui_renderable~render( ).

  ENDMETHOD.