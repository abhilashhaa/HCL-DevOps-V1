  METHOD zif_abapgit_log~add_exception.

    DATA lx_exc TYPE REF TO cx_root.
    DATA lv_msg TYPE string.
    lx_exc ?= ix_exc.
    DO.
      lv_msg = lx_exc->get_text( ).
      zif_abapgit_log~add( iv_msg  = lv_msg
                           iv_type = 'E'
                           is_item = is_item
                           ix_exc  = lx_exc ).
      IF lx_exc->previous IS BOUND.
        lx_exc = lx_exc->previous.
      ELSE.
        EXIT.
      ENDIF.
    ENDDO.

  ENDMETHOD.