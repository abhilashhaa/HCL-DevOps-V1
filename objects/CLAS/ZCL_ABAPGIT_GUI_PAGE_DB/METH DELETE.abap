  METHOD delete.

    DATA: lv_answer TYPE c LENGTH 1.

    ASSERT is_key-type IS NOT INITIAL.

    lv_answer = zcl_abapgit_ui_factory=>get_popups( )->popup_to_confirm(
      iv_titlebar              = 'Warning'
      iv_text_question         = 'Delete?'
      iv_text_button_1         = 'Ok'
      iv_icon_button_1         = 'ICON_DELETE'
      iv_text_button_2         = 'Cancel'
      iv_icon_button_2         = 'ICON_CANCEL'
      iv_default_button        = '2'
      iv_display_cancel_button = abap_false ).

    IF lv_answer = '2'.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    zcl_abapgit_persistence_db=>get_instance( )->delete(
      iv_type  = is_key-type
      iv_value = is_key-value ).

    COMMIT WORK.

  ENDMETHOD.