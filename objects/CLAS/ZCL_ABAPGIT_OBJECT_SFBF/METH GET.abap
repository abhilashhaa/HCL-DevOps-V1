  METHOD get.

    DATA: lv_bf TYPE sfw_bfunction.


    lv_bf = ms_item-obj_name.

    TRY.
* make sure to clear cache, method GET_BF_FROM_DB does not exist in 702
        ro_bf = cl_sfw_bf=>get_bf( lv_bf ).
        ro_bf->free( ).
        ro_bf = cl_sfw_bf=>get_bf( lv_bf ).
      CATCH cx_pak_invalid_data cx_pak_invalid_state cx_pak_not_authorized.
        zcx_abapgit_exception=>raise( 'Error from CL_SFW_BF=>GET_BF' ).
    ENDTRY.

  ENDMETHOD.