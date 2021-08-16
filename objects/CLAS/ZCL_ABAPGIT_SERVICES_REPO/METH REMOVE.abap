  METHOD remove.

    DATA: lv_answer    TYPE c LENGTH 1,
          lo_repo      TYPE REF TO zcl_abapgit_repo,
          lv_package   TYPE devclass,
          lv_question  TYPE c LENGTH 200,
          lv_repo_name TYPE string,
          lv_message   TYPE string.


    lo_repo      = zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).
    lv_repo_name = lo_repo->get_name( ).
    lv_package   = lo_repo->get_package( ).
    lv_question  = |This will remove the repository reference to the package { lv_package
      }. All objects will safely remain in the system.|.

    lv_answer = zcl_abapgit_ui_factory=>get_popups( )->popup_to_confirm(
      iv_titlebar              = 'Remove'
      iv_text_question         = lv_question
      iv_text_button_1         = 'Remove'
      iv_icon_button_1         = 'ICON_WF_UNLINK'
      iv_text_button_2         = 'Cancel'
      iv_icon_button_2         = 'ICON_CANCEL'
      iv_default_button        = '2'
      iv_display_cancel_button = abap_false ).

    IF lv_answer = '2'.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    zcl_abapgit_repo_srv=>get_instance( )->delete( lo_repo ).

    COMMIT WORK.

    lv_message = |Reference to repository { lv_repo_name } successfully removed from Package { lv_package }. |.
    MESSAGE lv_message TYPE 'S'.

  ENDMETHOD.