  METHOD add.

    DATA: lo_repo LIKE LINE OF mt_list.


    LOOP AT mt_list INTO lo_repo.
      IF lo_repo->get_key( ) = io_repo->get_key( ).
        IF lo_repo = io_repo.
          RETURN.
        ENDIF.
        zcx_abapgit_exception=>raise( 'identical keys' ).
      ENDIF.
    ENDLOOP.

    io_repo->bind_listener( me ).
    APPEND io_repo TO mt_list.

  ENDMETHOD.