  METHOD create_object.

    DATA: lv_name TYPE aab_id_name.


    lv_name = ms_item-obj_name.

    CREATE OBJECT ro_aab
      EXPORTING
        im_name          = lv_name
      EXCEPTIONS
        name_not_allowed = 1
        OTHERS           = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error creating CL_AAB_ID object' ).
    ENDIF.

  ENDMETHOD.