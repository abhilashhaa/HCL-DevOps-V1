  METHOD install_abapgit.

    CONSTANTS lc_title TYPE c LENGTH 40 VALUE 'Install abapGit'.
    DATA lv_text       TYPE c LENGTH 100.

    IF NOT is_installed( ) IS INITIAL.
      lv_text = 'Seems like abapGit package is already installed. No changes to be done'.
      zcl_abapgit_ui_factory=>get_popups( )->popup_to_inform(
        iv_titlebar     = lc_title
        iv_text_message = lv_text ).
      RETURN.
    ENDIF.

    lv_text = |Confirm to install current version of abapGit to package { c_abapgit_package }|.

    do_install( iv_title   = lc_title
                iv_text    = lv_text
                iv_url     = c_abapgit_url
                iv_package = c_abapgit_package ).

  ENDMETHOD.