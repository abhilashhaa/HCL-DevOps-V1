  METHOD call_delete_fms.

    CONSTANTS:
      lc_version_new      TYPE c VALUE 'N', "Include SCPRINTCONST version_new
      lc_operation_delete TYPE c VALUE 'D'.

    DATA:
      lv_profile_type   TYPE scprattr-type,
      lt_fatherprofiles TYPE STANDARD TABLE OF scproprof WITH DEFAULT KEY,
      ls_fatherprofile  TYPE scproprof.


    CALL FUNCTION 'SCPR_DB_ATTR_GET_DETAIL'
      EXPORTING
        profid   = iv_profile_id
        version  = lc_version_new
      IMPORTING
        proftype = lv_profile_type
      EXCEPTIONS
        OTHERS   = 0.

    CALL FUNCTION 'SCPR_PRSET_DB_USED_IN'
      EXPORTING
        profid   = iv_profile_id
        version  = lc_version_new
      TABLES
        profiles = lt_fatherprofiles.

    ls_fatherprofile-id = iv_profile_id.
    APPEND ls_fatherprofile TO lt_fatherprofiles.
    CALL FUNCTION 'SCPR_CT_TRANSPORT_ENTRIES'
      TABLES
        profids                  = lt_fatherprofiles
      EXCEPTIONS
        error_in_transport_layer = 1
        user_abort               = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |error while deleting SCP1 - TRANSPORT, { sy-subrc }| ).
    ENDIF.

    CALL FUNCTION 'SCPR_PRSET_DB_DELETE_ALL'
      EXPORTING
        profid      = iv_profile_id
        proftype    = lv_profile_type
      TABLES
        fatherprofs = lt_fatherprofiles
      EXCEPTIONS
        user_abort  = 1.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |error while deleting SCP1 - DB_DELETE, { sy-subrc }| ).
    ENDIF.

    CALL FUNCTION 'SCPR_MEM_SCPR_ACTIONS_ADD'
      EXPORTING
        bcset_id  = iv_profile_id
        operation = lc_operation_delete.

  ENDMETHOD.