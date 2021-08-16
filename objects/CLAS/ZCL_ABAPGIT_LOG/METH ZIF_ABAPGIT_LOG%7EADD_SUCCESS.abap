  METHOD zif_abapgit_log~add_success.

    zif_abapgit_log~add(
      iv_msg  = iv_msg
      iv_type = 'S'
      is_item = is_item ).

  ENDMETHOD.