  METHOD get_gui_functions.

    IF gi_gui_functions IS INITIAL.
      CREATE OBJECT gi_gui_functions TYPE zcl_abapgit_gui_functions.
    ENDIF.

    ri_gui_functions = gi_gui_functions.

  ENDMETHOD.