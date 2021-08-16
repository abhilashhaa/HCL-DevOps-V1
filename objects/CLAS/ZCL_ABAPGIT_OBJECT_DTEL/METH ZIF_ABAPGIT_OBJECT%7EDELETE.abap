  METHOD zif_abapgit_object~delete.

    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    delete_ddic( 'E' ).

    delete_longtexts( c_longtext_id_dtel ).

  ENDMETHOD.