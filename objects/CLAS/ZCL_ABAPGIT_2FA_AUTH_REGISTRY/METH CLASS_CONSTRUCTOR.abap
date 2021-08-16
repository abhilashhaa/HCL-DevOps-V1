  METHOD class_constructor.

    DATA: lt_sub             TYPE seo_relkeys,
          ls_sub             LIKE LINE OF lt_sub,
          li_authenticator   TYPE REF TO zif_abapgit_2fa_authenticator,
          lo_class           TYPE REF TO cl_oo_class,
          lv_warning_message TYPE string.


    TRY.
        lo_class ?= cl_oo_class=>get_instance( 'ZCL_ABAPGIT_2FA_AUTH_BASE' ).
        lt_sub = lo_class->get_subclasses( ).
        SORT lt_sub BY clsname ASCENDING AS TEXT.
        LOOP AT lt_sub INTO ls_sub.
          CREATE OBJECT li_authenticator TYPE (ls_sub-clsname).
          INSERT li_authenticator INTO TABLE gt_registered_authenticators.
        ENDLOOP.

        " Current 2FA approach will be removed as GitHub is deprecating the used authentication mechanism and there
        " are no other 2FA implementations. Show a warning in case someone subclassed ZCL_ABAPGIT_2FA_AUTH_BASE and
        " is using a custom 2FA implementation.
        " https://github.com/abapGit/abapGit/issues/3150
        " https://github.com/abapGit/abapGit/pull/3839

        IF gt_registered_authenticators IS NOT INITIAL AND
           zcl_abapgit_ui_factory=>get_gui_functions( )->gui_is_available( ) = abap_true.
          lv_warning_message = 'Custom 2FA implementation found. 2FA infrastructure is marked for deletion.' &&
                               ' Please open an issue if you are using it: github.com/abapGit/abapGit/issues/new'.
          MESSAGE lv_warning_message TYPE 'I' DISPLAY LIKE 'W'.
        ENDIF.
      CATCH cx_class_not_existent  ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.