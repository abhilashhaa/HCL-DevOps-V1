  METHOD get_log.
    DATA li_repo_log TYPE REF TO zif_abapgit_log.
    DATA lt_repo_msg TYPE zif_abapgit_log=>tty_log_out.
    DATA lr_repo_msg TYPE REF TO zif_abapgit_log=>ty_log_out.

    ri_log = mi_log.

    "add warning and error messages from repo log
    li_repo_log = mo_repo->get_log( ).
    IF li_repo_log IS BOUND.
      lt_repo_msg = li_repo_log->get_messages( ).
      LOOP AT lt_repo_msg REFERENCE INTO lr_repo_msg WHERE type CA 'EW'.
        CASE lr_repo_msg->type.
          WHEN 'E'.
            ri_log->add_error( iv_msg = lr_repo_msg->text ).
          WHEN 'W'.
            ri_log->add_warning( iv_msg = lr_repo_msg->text ).
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.