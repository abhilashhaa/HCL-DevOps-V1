  METHOD get_instance.

    IF go_instance IS INITIAL.
      go_instance = NEW #( ).
    ENDIF.

    ro_instance = go_instance.

  ENDMETHOD.