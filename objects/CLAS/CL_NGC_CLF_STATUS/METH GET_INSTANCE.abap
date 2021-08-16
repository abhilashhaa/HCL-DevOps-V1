  method GET_INSTANCE.

    IF go_instance IS INITIAL.
      go_instance = NEW cl_ngc_clf_status( ).
    ENDIF.

    ro_instance = go_instance.

  endmethod.