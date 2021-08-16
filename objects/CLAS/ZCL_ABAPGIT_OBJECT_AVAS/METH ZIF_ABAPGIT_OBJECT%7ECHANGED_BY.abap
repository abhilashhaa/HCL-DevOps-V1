  METHOD zif_abapgit_object~changed_by.

    DATA: lo_avas TYPE REF TO cl_cls_attr_value_assignment.


    lo_avas = instantiate( ).

    lo_avas->if_pak_wb_object~get_last_changed( IMPORTING ex_changed_by = rv_user ).

    IF rv_user IS INITIAL.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.