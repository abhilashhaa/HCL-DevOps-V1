  METHOD get_gui_services.
    IF gi_gui_services IS NOT BOUND.
      gi_gui_services ?= get_gui( ).
    ENDIF.
    ri_gui_services = gi_gui_services.
  ENDMETHOD.