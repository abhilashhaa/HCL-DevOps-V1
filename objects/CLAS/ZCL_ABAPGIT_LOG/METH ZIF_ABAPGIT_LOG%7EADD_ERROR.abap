  METHOD zif_abapgit_log~add_error.

    zif_abapgit_log~add(
      iv_msg  = iv_msg
      iv_type = 'E'
      is_item = is_item ).

  ENDMETHOD.