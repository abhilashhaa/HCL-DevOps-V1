  METHOD gui_services.
    IF mi_gui_services IS NOT BOUND.
      mi_gui_services = zcl_abapgit_ui_factory=>get_gui_services( ).
    ENDIF.
    ri_gui_services = mi_gui_services.
  ENDMETHOD.