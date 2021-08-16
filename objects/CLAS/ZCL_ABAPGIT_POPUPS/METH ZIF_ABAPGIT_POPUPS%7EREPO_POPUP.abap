  METHOD zif_abapgit_popups~repo_popup.

    DATA: lv_returncode       TYPE c,
          lv_icon_ok          TYPE icon-name,
          lv_icon_br          TYPE icon-name,
          lt_fields           TYPE TABLE OF sval,
          lv_uattr            TYPE spo_fattr,
          lv_pattr            TYPE spo_fattr,
          lv_button2          TYPE svalbutton-buttontext,
          lv_icon2            TYPE icon-name,
          lv_package          TYPE tdevc-devclass,
          lv_url              TYPE abaptxt255-line,
          lv_branch           TYPE textl-line,
          lv_display_name     TYPE trm255-text,
          lv_folder_logic     TYPE string,
          lv_ign_subpkg       TYPE abap_bool,
          lv_finished         TYPE abap_bool,
          lv_master_lang_only TYPE abap_bool,
          lx_error            TYPE REF TO zcx_abapgit_exception.

    IF iv_freeze_url = abap_true.
      lv_uattr = '05'.
    ENDIF.

    IF iv_freeze_package = abap_true.
      lv_pattr = '05'.
    ENDIF.

    IF iv_package IS INITIAL. " Empty package -> can be created
      lv_button2 = 'Create package'.
      lv_icon2   = icon_folder.
    ENDIF.

    lv_display_name = iv_display_name.
    lv_package = iv_package.
    lv_url     = iv_url.
    lv_branch  = iv_branch.

    WHILE lv_finished = abap_false.

      CLEAR: lt_fields.

      add_field( EXPORTING iv_tabname    = 'ABAPTXT255'
                           iv_fieldname  = 'LINE'
                           iv_fieldtext  = 'Git clone URL'
                           iv_value      = lv_url
                           iv_field_attr = lv_uattr
                 CHANGING ct_fields      = lt_fields ).

      add_field( EXPORTING iv_tabname    = 'TDEVC'
                           iv_fieldname  = 'DEVCLASS'
                           iv_fieldtext  = 'Package'
                           iv_value      = lv_package
                           iv_field_attr = lv_pattr
                 CHANGING ct_fields      = lt_fields ).

      add_field( EXPORTING iv_tabname    = 'TEXTL'
                           iv_fieldname  = 'LINE'
                           iv_fieldtext  = 'Branch'
                           iv_value      = lv_branch
                           iv_field_attr = '05'
                 CHANGING ct_fields      = lt_fields ).

      add_field( EXPORTING iv_tabname    = 'TRM255'
                           iv_fieldname  = 'TEXT'
                           iv_fieldtext  = 'Display name (opt.)'
                           iv_value      = lv_display_name
                 CHANGING ct_fields      = lt_fields ).

      add_field( EXPORTING iv_tabname    = 'TADIR'
                           iv_fieldname  = 'AUTHOR'
                           iv_fieldtext  = 'Folder logic'
                           iv_obligatory = abap_true
                           iv_value      = zif_abapgit_dot_abapgit=>c_folder_logic-prefix
                 CHANGING ct_fields      = lt_fields ).

      add_field( EXPORTING iv_tabname    = 'TDEVC'
                           iv_fieldname  = 'IS_ENHANCEABLE'
                           iv_fieldtext  = 'Ignore subpackages'
                           iv_value      = abap_false
                 CHANGING ct_fields      = lt_fields ).

      add_field( EXPORTING iv_tabname    = 'DOKIL'
                           iv_fieldname  = 'MASTERLANG'
                           iv_fieldtext  = 'Master language only'
                           iv_value      = abap_true
                  CHANGING ct_fields     = lt_fields ).

      lv_icon_ok  = icon_okay.
      lv_icon_br  = icon_workflow_fork.

      CALL FUNCTION 'POPUP_GET_VALUES_USER_BUTTONS'
        EXPORTING
          popup_title       = iv_title
          programname       = sy-cprog
          formname          = 'BRANCH_POPUP'
          ok_pushbuttontext = 'OK'
          icon_ok_push      = lv_icon_ok
          first_pushbutton  = 'Select branch'
          icon_button_1     = lv_icon_br
          second_pushbutton = lv_button2
          icon_button_2     = lv_icon2
        IMPORTING
          returncode        = lv_returncode
        TABLES
          fields            = lt_fields
        EXCEPTIONS
          error_in_fields   = 1
          OTHERS            = 2.

      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'Error from POPUP_GET_VALUES' ).
      ENDIF.

      IF lv_returncode = c_answer_cancel.
        rs_popup-cancel = abap_true.
        RETURN.
      ENDIF.

      extract_field_values(
        EXPORTING
          it_fields       = lt_fields
        IMPORTING
          ev_url          = lv_url
          ev_package      = lv_package
          ev_branch       = lv_branch
          ev_display_name = lv_display_name
          ev_folder_logic = lv_folder_logic
          ev_ign_subpkg   = lv_ign_subpkg
          ev_master_lang_only = lv_master_lang_only ).

      lv_finished = abap_true.

      TRY.
          IF iv_freeze_url = abap_false.
            zcl_abapgit_url=>validate( |{ lv_url }| ).
          ENDIF.
          IF iv_freeze_package = abap_false.
            zcl_abapgit_repo_srv=>get_instance( )->validate_package( iv_package    = lv_package
                                                                     iv_ign_subpkg = lv_ign_subpkg
                                                                     iv_chk_exists = abap_false ).
          ENDIF.
          validate_folder_logic( lv_folder_logic ).
        CATCH zcx_abapgit_exception INTO lx_error.
          MESSAGE lx_error TYPE 'S' DISPLAY LIKE 'E'.
          " in case of validation errors we display the popup again
          CLEAR lv_finished.
      ENDTRY.

    ENDWHILE.

    rs_popup-url                = lv_url.
    rs_popup-package            = lv_package.
    rs_popup-branch_name        = lv_branch.
    rs_popup-display_name       = lv_display_name.
    rs_popup-folder_logic       = lv_folder_logic.
    rs_popup-ign_subpkg         = lv_ign_subpkg.
    rs_popup-master_lang_only   = lv_master_lang_only.

  ENDMETHOD.