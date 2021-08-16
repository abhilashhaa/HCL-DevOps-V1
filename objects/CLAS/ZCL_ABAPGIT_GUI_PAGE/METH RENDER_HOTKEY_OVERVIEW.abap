  METHOD render_hotkey_overview.

    DATA lo_hotkeys_component TYPE REF TO zif_abapgit_gui_renderable.

    lo_hotkeys_component ?= gui_services( )->get_hotkeys_ctl( ). " Mmmm ...
    ro_html = lo_hotkeys_component->render( ).

  ENDMETHOD.