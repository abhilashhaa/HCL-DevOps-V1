  METHOD reset.

    DATA: lo_repo                   TYPE REF TO zcl_abapgit_repo,
          lv_answer                 TYPE c LENGTH 1,
          lt_unnecessary_local_objs TYPE zif_abapgit_definitions=>ty_tadir_tt,
          lt_selected               LIKE lt_unnecessary_local_objs,
          lt_columns                TYPE zif_abapgit_definitions=>ty_alv_column_tt,
          ls_checks                 TYPE zif_abapgit_definitions=>ty_delete_checks,
          li_popups                 TYPE REF TO zif_abapgit_popups.

    FIELD-SYMBOLS: <ls_column> TYPE zif_abapgit_definitions=>ty_alv_column.

    lo_repo = zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).

    IF lo_repo->get_local_settings( )-write_protected = abap_true.
      zcx_abapgit_exception=>raise( 'Cannot reset. Local code is write-protected by repo config' ).
    ENDIF.

* todo, separate UI and logic
    lv_answer = zcl_abapgit_ui_factory=>get_popups( )->popup_to_confirm(
      iv_titlebar              = 'Warning'
      iv_text_question         = 'Reset local objects?'
      iv_text_button_1         = 'Ok'
      iv_icon_button_1         = 'ICON_OKAY'
      iv_text_button_2         = 'Cancel'
      iv_icon_button_2         = 'ICON_CANCEL'
      iv_default_button        = '2'
      iv_display_cancel_button = abap_false ).

    IF lv_answer = '2'.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    lt_unnecessary_local_objs = get_unnecessary_local_objs( lo_repo ).

    IF lines( lt_unnecessary_local_objs ) > 0.

      APPEND INITIAL LINE TO lt_columns ASSIGNING <ls_column>.
      <ls_column>-name = 'OBJECT'.
      APPEND INITIAL LINE TO lt_columns ASSIGNING <ls_column>.
      <ls_column>-name = 'OBJ_NAME'.

      li_popups = zcl_abapgit_ui_factory=>get_popups( ).
      li_popups->popup_to_select_from_list(
        EXPORTING
          it_list               = lt_unnecessary_local_objs
          iv_header_text        = |Which unnecessary objects should be deleted?|
          iv_select_column_text = 'Delete?'
          it_columns_to_display = lt_columns
        IMPORTING
          et_list              = lt_selected ).

      IF lines( lt_selected ) > 0.

        ls_checks = lo_repo->delete_checks( ).
        IF ls_checks-transport-required = abap_true.
          ls_checks-transport-transport = zcl_abapgit_ui_factory=>get_popups(
                                            )->popup_transport_request( ls_checks-transport-type ).
        ENDIF.

        zcl_abapgit_objects=>delete( it_tadir  = lt_selected
                                     is_checks = ls_checks ).

        lo_repo->refresh( ).

      ENDIF.

    ENDIF.

    zcl_abapgit_services_repo=>gui_deserialize( lo_repo ).

  ENDMETHOD.