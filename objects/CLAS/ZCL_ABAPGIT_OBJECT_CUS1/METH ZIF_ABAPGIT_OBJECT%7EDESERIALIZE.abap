  METHOD zif_abapgit_object~deserialize.

    DATA: ls_customzing_activity TYPE ty_customzing_activity,
          ls_message             TYPE hier_mess.

    io_xml->read(
      EXPORTING
        iv_name = 'CUS1'
      CHANGING
        cg_data = ls_customzing_activity ).

    CALL FUNCTION 'S_CUS_ACTIVITY_SAVE'
      EXPORTING
        activity                     = ls_customzing_activity-activity_header-act_id
        activity_type                = ls_customzing_activity-activity_header-act_type
        tcode                        = ls_customzing_activity-activity_header-tcode
        customer_exit                = ls_customzing_activity-activity_customer_exit-exit_name
        customer_exit_enhancement    = ls_customzing_activity-activity_customer_exit-enhancement
        customer_exit_implementation = ls_customzing_activity-activity_customer_exit-impl_name
      IMPORTING
        message                      = ls_message
      TABLES
        activity_title               = ls_customzing_activity-activity_title
        objects                      = ls_customzing_activity-objects
        objects_texts                = ls_customzing_activity-objects_title.

    IF ls_message-msgty <> 'S'.
      zcx_abapgit_exception=>raise( |error from deserialize CUS1 { mv_customizing_activity } S_CUS_ACTIVITY_SAVE| ).
    ENDIF.

    CALL FUNCTION 'RS_CORR_INSERT'
      EXPORTING
        object              = ms_item-obj_name
        object_class        = ms_item-obj_type
        mode                = 'I'
        global_lock         = abap_true
        devclass            = iv_package
        master_language     = mv_language
        suppress_dialog     = abap_true
      EXCEPTIONS
        cancelled           = 1
        permission_failure  = 2
        unknown_objectclass = 3
        OTHERS              = 4.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from RS_CORR_INSERT, CUS0' ).
    ENDIF.

  ENDMETHOD.