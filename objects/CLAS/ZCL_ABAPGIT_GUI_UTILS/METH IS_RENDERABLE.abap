  METHOD is_renderable.
    DATA li_renderable TYPE REF TO zif_abapgit_gui_renderable.
    TRY.
        li_renderable ?= io_obj.
        rv_yes = abap_true.
      CATCH cx_sy_move_cast_error.
        rv_yes = abap_false.
    ENDTRY.
  ENDMETHOD.