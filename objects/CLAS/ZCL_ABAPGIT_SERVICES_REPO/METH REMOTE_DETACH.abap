  METHOD remote_detach.

    DATA: lv_answer TYPE c LENGTH 1.

    lv_answer = zcl_abapgit_ui_factory=>get_popups( )->popup_to_confirm(
      iv_titlebar              = 'Make repository OFF-line'
      iv_text_question         = 'This will detach the repo from remote and make it OFF-line'
      iv_text_button_1         = 'Make OFF-line'
      iv_icon_button_1         = 'ICON_WF_UNLINK'
      iv_text_button_2         = 'Cancel'
      iv_icon_button_2         = 'ICON_CANCEL'
      iv_default_button        = '2'
      iv_display_cancel_button = abap_false ).

    IF lv_answer = '2'.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    zcl_abapgit_repo_srv=>get_instance( )->get( iv_key )->switch_repo_type( iv_offline = abap_true ).

    COMMIT WORK.

  ENDMETHOD.