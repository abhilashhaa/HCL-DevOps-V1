  METHOD determine_check_variant.

    mv_check_variant = mo_repo->get_local_settings( )-code_inspector_check_variant.

    IF mv_check_variant IS INITIAL.
      mv_check_variant = ask_user_for_check_variant( ).
    ENDIF.

  ENDMETHOD.