  METHOD check_sapgui.

    CONSTANTS:
      lc_hide_sapgui_hint TYPE string VALUE '2'.

    DATA:
      lv_answer           TYPE char1,
      ls_settings         TYPE zif_abapgit_definitions=>ty_s_user_settings,
      li_user_persistence TYPE REF TO zif_abapgit_persist_user.

    li_user_persistence = zcl_abapgit_persistence_user=>get_instance( ).

    ls_settings = li_user_persistence->get_settings( ).

    IF ls_settings-hide_sapgui_hint = abap_true.
      RETURN.
    ENDIF.

    IF zcl_abapgit_ui_factory=>get_gui_functions( )->is_sapgui_for_java( ) = abap_false.
      RETURN.
    ENDIF.

    lv_answer = zcl_abapgit_ui_factory=>get_popups( )->popup_to_confirm(
                    iv_titlebar              = 'Not supported SAPGUI'
                    iv_text_question         = 'SAPGUI for Java is not supported! There might be some issues.'
                    iv_text_button_1         = 'Got it'
                    iv_icon_button_1         = |{ icon_okay }|
                    iv_text_button_2         = 'Hide'
                    iv_icon_button_2         = |{ icon_set_state }|
                    iv_display_cancel_button = abap_false ).

    IF lv_answer = lc_hide_sapgui_hint.
      ls_settings-hide_sapgui_hint = abap_true.
      li_user_persistence->set_settings( ls_settings ).
    ENDIF.

  ENDMETHOD.