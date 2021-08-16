  METHOD activate_new.

    DATA: li_progress TYPE REF TO zif_abapgit_progress.

    IF gt_objects IS INITIAL.
      RETURN.
    ENDIF.

    li_progress = zcl_abapgit_progress=>get_instance( 100 ).

    IF iv_ddic = abap_true.

      li_progress->show( iv_current = 98
                         iv_text    = 'Activating DDIC' ).

      activate_ddic( ).

    ELSE.

      li_progress->show( iv_current = 98
                         iv_text    = 'Activating non DDIC' ).

      activate_old( ).

    ENDIF.

  ENDMETHOD.