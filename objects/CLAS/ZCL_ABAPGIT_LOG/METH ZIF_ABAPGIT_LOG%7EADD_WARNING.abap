  METHOD zif_abapgit_log~add_warning.

    zif_abapgit_log~add(
      iv_msg  = iv_msg
      iv_type = 'W'
      is_item = is_item ).

  ENDMETHOD.