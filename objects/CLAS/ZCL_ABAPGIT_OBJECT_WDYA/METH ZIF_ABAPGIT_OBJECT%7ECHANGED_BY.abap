  METHOD zif_abapgit_object~changed_by.

    DATA: li_app  TYPE REF TO if_wdy_md_application,
          ls_app  TYPE wdy_application,
          lv_name TYPE wdy_application_name.


    lv_name = ms_item-obj_name.
    TRY.
        li_app = cl_wdy_md_application=>get_object_by_key(
                   name    = lv_name
                   version = 'A' ).

        li_app->if_wdy_md_object~get_definition( IMPORTING definition = ls_app ).

        IF ls_app-changedby IS INITIAL.
          rv_user = ls_app-author.
        ELSE.
          rv_user = ls_app-changedby.
        ENDIF.
      CATCH cx_root.
        rv_user = c_user_unknown.
    ENDTRY.

  ENDMETHOD.