  METHOD zif_abapgit_object~serialize.

    DATA: ls_img_activity TYPE ty_img_activity.

    CALL FUNCTION 'S_CUS_IMG_ACTIVITY_READ'
      EXPORTING
        img_activity        = mv_img_activity
      IMPORTING
        img_activity_header = ls_img_activity-header
      TABLES
        img_activity_texts  = ls_img_activity-texts.

    CLEAR: ls_img_activity-header-fuser,
           ls_img_activity-header-fdate,
           ls_img_activity-header-ftime,
           ls_img_activity-header-luser,
           ls_img_activity-header-ldate,
           ls_img_activity-header-ltime.

    IF io_xml->i18n_params( )-serialize_master_lang_only = abap_true.
      DELETE ls_img_activity-texts WHERE spras <> mv_language.
    ENDIF.

    io_xml->add( iv_name = 'CUS0'
                 ig_data = ls_img_activity ).

  ENDMETHOD.