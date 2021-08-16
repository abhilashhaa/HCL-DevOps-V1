  METHOD zif_abapgit_object~delete.

    DATA: lv_switch_id TYPE sfw_switch_id,
          lo_switch    TYPE REF TO cl_sfw_sw.


    lv_switch_id = ms_item-obj_name.
    TRY.
        lo_switch = cl_sfw_sw=>get_switch( lv_switch_id ).
        lo_switch->set_delete_flag( lv_switch_id ).
        lo_switch->save_all( ).

        " deletion via background job. Wait until the job is finished...
        wait_for_background_job( ).

        " ... the object is deleted
        wait_for_deletion( ).

      CATCH cx_pak_invalid_data cx_pak_invalid_state cx_pak_not_authorized.
        zcx_abapgit_exception=>raise( 'Error deleting Switch' ).
    ENDTRY.

  ENDMETHOD.