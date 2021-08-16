  METHOD zif_abapgit_gui_functions~gui_is_available.

    CALL FUNCTION 'GUI_IS_AVAILABLE'
      IMPORTING
        return = rv_gui_is_available.

  ENDMETHOD.