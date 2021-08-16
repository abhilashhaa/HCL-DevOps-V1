  METHOD zif_abapgit_object~serialize.

    DATA: ls_customzing_activity TYPE ty_customzing_activity.

    CALL FUNCTION 'S_CUS_ACTIVITY_READ'
      EXPORTING
        activity               = mv_customizing_activity
      IMPORTING
        activity_header        = ls_customzing_activity-activity_header
        activity_customer_exit = ls_customzing_activity-activity_customer_exit
      TABLES
        activity_title         = ls_customzing_activity-activity_title
        objects                = ls_customzing_activity-objects
        objects_title          = ls_customzing_activity-objects_title.

    CLEAR: ls_customzing_activity-activity_header-fdatetime,
           ls_customzing_activity-activity_header-fuser,
           ls_customzing_activity-activity_header-ldatetime,
           ls_customzing_activity-activity_header-luser.

    IF io_xml->i18n_params( )-serialize_master_lang_only = abap_true.
      DELETE ls_customzing_activity-activity_title WHERE spras <> mv_language.
    ENDIF.

    io_xml->add( iv_name = 'CUS1'
                 ig_data = ls_customzing_activity ).

  ENDMETHOD.