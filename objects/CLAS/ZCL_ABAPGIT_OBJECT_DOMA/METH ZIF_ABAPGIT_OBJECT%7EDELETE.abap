  METHOD zif_abapgit_object~delete.

    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    delete_ddic( iv_objtype              = 'D'
                 iv_no_ask_delete_append = abap_true ).

    delete_longtexts( c_longtext_id_doma ).

  ENDMETHOD.