  METHOD refresh_local_checksums.

    DATA: lv_answer   TYPE c,
          lv_question TYPE string,
          lo_repo     TYPE REF TO zcl_abapgit_repo.


    IF zcl_abapgit_auth=>is_allowed( zif_abapgit_auth=>gc_authorization-update_local_checksum ) = abap_false.
      zcx_abapgit_exception=>raise( 'Not authorized' ).
    ENDIF.

    lo_repo = zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).

    lv_question = 'This will rebuild and overwrite local repo checksums.'.

    IF lo_repo->is_offline( ) = abap_false.
      lv_question = lv_question
                && ' The logic: if local and remote file differs then:'
                && ' if remote branch is ahead then assume changes are remote,'
                && ' else (branches are equal) assume changes are local.'
                && ' This will lead to incorrect state for files changed on both sides.'
                && ' Please make sure you don''t have ones like that.'.
    ENDIF.

    lv_answer = zcl_abapgit_ui_factory=>get_popups( )->popup_to_confirm(
      iv_titlebar              = 'Warning'
      iv_text_question         = lv_question
      iv_text_button_1         = 'OK'
      iv_icon_button_1         = 'ICON_DELETE'
      iv_text_button_2         = 'Cancel'
      iv_icon_button_2         = 'ICON_CANCEL'
      iv_default_button        = '2'
      iv_display_cancel_button = abap_false ).

    IF lv_answer = '2'.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    lo_repo->rebuild_local_checksums( ).

    COMMIT WORK AND WAIT.

  ENDMETHOD.