  METHOD get.

    DATA: lv_bfset TYPE sfw_bset.


    lv_bfset = ms_item-obj_name.

    TRY.
        ro_bfs = cl_sfw_bfs=>get_bfs( lv_bfset ).
        ro_bfs->free( ).
        ro_bfs = cl_sfw_bfs=>get_bfs( lv_bfset ).
      CATCH cx_pak_invalid_data cx_pak_invalid_state cx_pak_not_authorized.
        zcx_abapgit_exception=>raise( 'Error from CL_SFW_BFS=>GET_BFS' ).
    ENDTRY.

  ENDMETHOD.