  METHOD zif_abapgit_object~delete.

    CALL FUNCTION 'RH_HRSOBJECT_DELETE'
      EXPORTING
        act_otype           = c_object_type_task
        act_objid           = mv_objid
        no_confirmation_msg = abap_true
      EXCEPTIONS
        enqueue_failed      = 1
        object_not_deleted  = 2
        object_not_found    = 3
        OTHERS              = 4.       "#EC SUBRC_OK

    check_subrc_for( `RH_HRSOBJECT_DELETE` ).

  ENDMETHOD.