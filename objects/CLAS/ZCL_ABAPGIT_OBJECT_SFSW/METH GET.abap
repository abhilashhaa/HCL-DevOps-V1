  METHOD get.

    DATA: lv_switch_id TYPE sfw_switch_id.

    lv_switch_id = ms_item-obj_name.

    TRY.
        ro_switch = cl_sfw_sw=>get_switch_from_db( lv_switch_id ).
      CATCH cx_pak_invalid_data cx_pak_invalid_state cx_pak_not_authorized.
        zcx_abapgit_exception=>raise( 'Error from CL_SFW_SW=>GET_SWITCH' ).
    ENDTRY.

  ENDMETHOD.