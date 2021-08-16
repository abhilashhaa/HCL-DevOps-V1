  METHOD exists.

    IF is_item IS INITIAL.
      RETURN.
    ENDIF.

    IF zcl_abapgit_objects=>is_supported( is_item ) = abap_false.
      rv_exists = abap_true.
      RETURN.
    ENDIF.

    rv_exists = zcl_abapgit_objects=>exists( is_item ).

  ENDMETHOD.