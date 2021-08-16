  METHOD save.

    DATA: li_prop TYPE REF TO if_wdy_md_application_property,
          lo_app  TYPE REF TO cl_wdy_md_application.

    FIELD-SYMBOLS: <ls_property> LIKE LINE OF it_properties.


    TRY.
        CREATE OBJECT lo_app
          EXPORTING
            name       = is_app-application_name
            definition = is_app
            devclass   = iv_package.

        LOOP AT it_properties ASSIGNING <ls_property>.
          li_prop = lo_app->if_wdy_md_application~create_property( <ls_property>-name ).
          li_prop->set_value( <ls_property>-value ).
        ENDLOOP.

        tadir_insert( iv_package ).

        lo_app->if_wdy_md_lockable_object~save_to_database( ).
      CATCH cx_wdy_md_exception.
        zcx_abapgit_exception=>raise( 'error saving WDYA' ).
    ENDTRY.

  ENDMETHOD.