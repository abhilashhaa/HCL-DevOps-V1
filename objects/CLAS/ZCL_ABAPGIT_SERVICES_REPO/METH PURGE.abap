  METHOD purge.

    DATA: lt_tadir     TYPE zif_abapgit_definitions=>ty_tadir_tt,
          lv_answer    TYPE c LENGTH 1,
          lo_repo      TYPE REF TO zcl_abapgit_repo,
          lv_package   TYPE devclass,
          lv_question  TYPE c LENGTH 100,
          ls_checks    TYPE zif_abapgit_definitions=>ty_delete_checks,
          lv_repo_name TYPE string,
          lv_message   TYPE string.


    lo_repo = zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).
    lv_repo_name = lo_repo->get_name( ).

    lv_package = lo_repo->get_package( ).
    lt_tadir   = zcl_abapgit_factory=>get_tadir( )->read( lv_package ).

    IF lines( lt_tadir ) > 0.

      lv_question = |This will DELETE all objects in package { lv_package
        } ({ lines( lt_tadir ) } objects) from the system|.

      lv_answer = zcl_abapgit_ui_factory=>get_popups( )->popup_to_confirm(
        iv_titlebar              = 'Uninstall'
        iv_text_question         = lv_question
        iv_text_button_1         = 'Delete'
        iv_icon_button_1         = 'ICON_DELETE'
        iv_text_button_2         = 'Cancel'
        iv_icon_button_2         = 'ICON_CANCEL'
        iv_default_button        = '2'
        iv_display_cancel_button = abap_false ).

      IF lv_answer = '2'.
        RAISE EXCEPTION TYPE zcx_abapgit_cancel.
      ENDIF.

    ENDIF.

    ls_checks = lo_repo->delete_checks( ).
    IF ls_checks-transport-required = abap_true.
      ls_checks-transport-transport = zcl_abapgit_ui_factory=>get_popups(
                                        )->popup_transport_request( ls_checks-transport-type ).
    ENDIF.

    zcl_abapgit_repo_srv=>get_instance( )->purge( io_repo   = lo_repo
                                                  is_checks = ls_checks ).

    COMMIT WORK.

    lv_message = |Repository { lv_repo_name } successfully uninstalled from Package { lv_package }. |.
    MESSAGE lv_message TYPE 'S'.

  ENDMETHOD.