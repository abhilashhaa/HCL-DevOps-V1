  METHOD zif_abapgit_object~deserialize.

    DATA: lo_persist      TYPE REF TO object,
          lo_profile      TYPE REF TO object,
          lr_wb           TYPE REF TO data,
          lr_profile_data TYPE REF TO data.
    FIELD-SYMBOLS: <ls_profile_data> TYPE data,
                   <lo_wb>           TYPE any.

    CREATE DATA lr_profile_data TYPE ('OA2C_SX_OA2P_OBJECT_DATA').
    ASSIGN lr_profile_data->* TO <ls_profile_data>.

    io_xml->read( EXPORTING iv_name = 'PROFILE'
                  CHANGING cg_data = <ls_profile_data> ).



    CREATE OBJECT lo_profile TYPE ('CL_OA2P_OBJECT_DATA').
    CREATE DATA lr_wb TYPE REF TO ('IF_WB_OBJECT_DATA_MODEL').
    ASSIGN lr_wb->* TO <lo_wb>.
    <lo_wb> ?= lo_profile.

    CALL METHOD lo_profile->('IF_WB_OBJECT_DATA_MODEL~SET_DATA')
      EXPORTING
        p_data = <ls_profile_data>.

    CREATE OBJECT lo_persist TYPE ('CL_OA2P_OBJECT_PERSIST').
    TRY.
        CALL METHOD lo_persist->('IF_WB_OBJECT_PERSIST~SAVE')
          EXPORTING
            p_object_data = <lo_wb>.   " Object Data
      CATCH cx_swb_exception.
        zcx_abapgit_exception=>raise( |Error deserialize profile { mv_profile }.| ).
    ENDTRY.

    tadir_insert( iv_package ).

    corr_insert( iv_package ).

  ENDMETHOD.