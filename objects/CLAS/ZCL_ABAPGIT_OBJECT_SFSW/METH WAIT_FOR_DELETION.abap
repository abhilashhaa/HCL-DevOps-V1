  METHOD wait_for_deletion.

    DO 5 TIMES.

      IF zif_abapgit_object~exists( ) = abap_true.
        WAIT UP TO 1 SECONDS.
      ELSE.
        EXIT.
      ENDIF.

    ENDDO.

  ENDMETHOD.