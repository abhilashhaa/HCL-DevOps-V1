  METHOD zif_abapgit_gui_functions~is_sapgui_for_java.

    CALL FUNCTION 'GUI_HAS_JAVABEANS'
      IMPORTING
        return = rv_result.

  ENDMETHOD.