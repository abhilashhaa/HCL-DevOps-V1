  METHOD zif_abapgit_object~delete.

    DATA:
      lv_object       TYPE string,
      lv_object_class TYPE string,
      lv_transp_pkg   TYPE abap_bool,
      lv_dummy        TYPE string.

    CONSTANTS: lc_actvt TYPE c LENGTH 2 VALUE `06`.


    DATA: lo_persist     TYPE REF TO object,
          lv_profile_key TYPE seu_objkey.

    "authority check
    AUTHORITY-CHECK OBJECT 'S_OA2C_ADM'
      ID 'ACTVT'     FIELD lc_actvt.
    IF sy-subrc <> 0.
      MESSAGE e463(01) WITH mv_profile INTO lv_dummy.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    "delete profile
    lv_profile_key = mv_profile.
    CREATE OBJECT lo_persist TYPE ('CL_OA2P_OBJECT_PERSIST').

    TRY.
        CALL METHOD lo_persist->('IF_WB_OBJECT_PERSIST~DELETE')
          EXPORTING
            p_object_key = lv_profile_key.   " Object Key
      CATCH cx_swb_object_does_not_exist.
      CATCH cx_swb_exception.
        zcx_abapgit_exception=>raise( |Error when deleting OAuth2 Profile { lv_profile_key }.| ).
    ENDTRY.


    "collect change in transport
    lv_transp_pkg = zcl_abapgit_factory=>get_sap_package( iv_package )->are_changes_recorded_in_tr_req( ).
    IF lv_transp_pkg = abap_true.

      lv_object_class = ms_item-obj_type.
      lv_object       = ms_item-obj_name.

      CALL FUNCTION 'RS_CORR_INSERT'
        EXPORTING
          object              = lv_object
          object_class        = lv_object_class
          master_language     = mv_language
          global_lock         = abap_true
          mode                = 'D'
          suppress_dialog     = abap_true
        EXCEPTIONS
          cancelled           = 1
          permission_failure  = 2
          unknown_objectclass = 3
          OTHERS              = 4.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise_t100(
            iv_msgid              = sy-msgid
            iv_msgno              = sy-msgno
            iv_msgv1              = sy-msgv1
            iv_msgv2              = sy-msgv2
            iv_msgv3              = sy-msgv3
            iv_msgv4              = sy-msgv4 ).
      ENDIF.
    ENDIF.


  ENDMETHOD.