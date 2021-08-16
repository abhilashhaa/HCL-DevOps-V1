  METHOD zif_abapgit_object~changed_by.

    DATA: lo_persist     TYPE REF TO object,
          lr_wb          TYPE REF TO data,
          lo_profile     TYPE REF TO object,
          lv_profile_key TYPE seu_objkey.

    FIELD-SYMBOLS: <lo_wb> TYPE any.


    lv_profile_key = mv_profile.
    CREATE OBJECT lo_persist TYPE ('CL_OA2P_OBJECT_PERSIST').

    CREATE OBJECT lo_profile TYPE ('CL_OA2P_OBJECT_DATA').
    CREATE DATA lr_wb TYPE REF TO ('IF_WB_OBJECT_DATA_MODEL').
    ASSIGN lr_wb->* TO <lo_wb>.
    <lo_wb> ?= lo_profile.

    TRY.
        CALL METHOD lo_persist->('IF_WB_OBJECT_PERSIST~GET')
          EXPORTING
            p_object_key  = lv_profile_key    " Object Key
            p_version     = 'A'    " Version (Active/Inactive)
          CHANGING
            p_object_data = <lo_wb>.  " Object Data
      CATCH cx_swb_object_does_not_exist.
        zcx_abapgit_exception=>raise( |OAuth2 Profile { lv_profile_key } doesn't exist.| ).
      CATCH cx_swb_exception.
        zcx_abapgit_exception=>raise( |Error when geting details of OAuth2 Profile { lv_profile_key }.| ).
    ENDTRY.

    lo_profile = <lo_wb>.
    CALL METHOD lo_profile->('IF_WB_OBJECT_DATA_MODEL~GET_CHANGED_BY')
      RECEIVING
        p_user_name = rv_user.


  ENDMETHOD.