  METHOD zif_abapgit_popups~repo_new_offline.

    DATA: lv_returncode TYPE c,
          lt_fields     TYPE TABLE OF sval,
          lv_icon_ok    TYPE icon-name,
          lv_button1    TYPE svalbutton-buttontext,
          lv_icon1      TYPE icon-name,
          lv_finished   TYPE abap_bool,
          lx_error      TYPE REF TO zcx_abapgit_exception.

    FIELD-SYMBOLS: <ls_field> LIKE LINE OF lt_fields.


    add_field( EXPORTING iv_tabname    = 'ABAPTXT255'
                         iv_fieldname  = 'LINE'
                         iv_fieldtext  = 'Name'
                         iv_obligatory = abap_true
               CHANGING  ct_fields     = lt_fields ).

    add_field( EXPORTING iv_tabname    = 'TDEVC'
                         iv_fieldname  = 'DEVCLASS'
                         iv_fieldtext  = 'Package'
                         iv_obligatory = abap_true
               CHANGING  ct_fields     = lt_fields ).

    add_field( EXPORTING iv_tabname    = 'ZABAPGIT'
                         iv_fieldname  = 'VALUE'
                         iv_fieldtext  = 'Folder logic'
                         iv_obligatory = abap_true
                         iv_value      = zif_abapgit_dot_abapgit=>c_folder_logic-prefix
               CHANGING  ct_fields     = lt_fields ).

    add_field( EXPORTING iv_tabname    = 'DOKIL'
                         iv_fieldname  = 'MASTERLANG'
                         iv_fieldtext  = 'Master language only'
                         iv_value      = abap_true
               CHANGING ct_fields      = lt_fields ).

    WHILE lv_finished = abap_false.

      lv_icon_ok  = icon_okay.
      lv_button1 = 'Create package'.
      lv_icon1   = icon_folder.

      CALL FUNCTION 'POPUP_GET_VALUES_USER_BUTTONS'
        EXPORTING
          popup_title       = 'New Offline Project'
          programname       = sy-cprog
          formname          = 'PACKAGE_POPUP'
          ok_pushbuttontext = 'OK'
          icon_ok_push      = lv_icon_ok
          first_pushbutton  = lv_button1
          icon_button_1     = lv_icon1
          second_pushbutton = ''
          icon_button_2     = ''
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

      READ TABLE lt_fields INDEX 1 ASSIGNING <ls_field>.
      ASSERT sy-subrc = 0.
      rs_popup-url = <ls_field>-value.

      READ TABLE lt_fields INDEX 2 ASSIGNING <ls_field>.
      ASSERT sy-subrc = 0.
      TRANSLATE <ls_field>-value TO UPPER CASE.
      rs_popup-package = <ls_field>-value.

      READ TABLE lt_fields INDEX 3 ASSIGNING <ls_field>.
      ASSERT sy-subrc = 0.
      TRANSLATE <ls_field>-value TO UPPER CASE.
      rs_popup-folder_logic = <ls_field>-value.

      READ TABLE lt_fields INDEX 4 ASSIGNING <ls_field>.
      ASSERT sy-subrc = 0.
      rs_popup-master_lang_only = <ls_field>-value.

      lv_finished = abap_true.

      TRY.
          zcl_abapgit_repo_srv=>get_instance( )->validate_package( iv_package    = rs_popup-package
                                                                   iv_chk_exists = abap_false ).
          validate_folder_logic( rs_popup-folder_logic ).

        CATCH zcx_abapgit_exception INTO lx_error.
          " in case of validation errors we display the popup again
          MESSAGE lx_error TYPE 'S' DISPLAY LIKE 'E'.
          CLEAR lv_finished.
      ENDTRY.

    ENDWHILE.

  ENDMETHOD.