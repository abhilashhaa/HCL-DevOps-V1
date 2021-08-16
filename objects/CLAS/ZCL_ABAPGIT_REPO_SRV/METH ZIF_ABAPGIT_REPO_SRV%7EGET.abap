  METHOD zif_abapgit_repo_srv~get.

    FIELD-SYMBOLS: <lo_list> LIKE LINE OF mt_list.

    IF mv_init = abap_false.
      refresh( ).
    ENDIF.

    DO 2 TIMES.
      " Repo might have been created in another session. Try again after refresh
      IF sy-index = 2.
        refresh( ).
      ENDIF.
      LOOP AT mt_list ASSIGNING <lo_list>.
        IF <lo_list>->get_key( ) = iv_key.
          ro_repo = <lo_list>.
          RETURN.
        ENDIF.
      ENDLOOP.
    ENDDO.

    zcx_abapgit_exception=>raise( 'repo not found, get' ).

  ENDMETHOD.