  METHOD zif_abapgit_object~deserialize.

    DATA: lv_bf                TYPE sfw_bfunction,
          lo_bf                TYPE REF TO cl_sfw_bf,
          ls_header            TYPE sfw_bf,
          lv_name_32           TYPE sfw_name32,
          lv_name_80           TYPE sfw_name80,
          lt_assigned_switches TYPE sfw_swbf_outtab,
          lt_dependancies      TYPE sfw_depend_outtab,
          ls_sfw_bfc_kw        TYPE sfw_bfc_kw,
          ls_sfw_bfc_tc        TYPE sfw_bfc_tc,
          ls_sfw_bfc_rn        TYPE sfw_bfc_rn,
          lt_parent_bfs        TYPE sfw_bs_bf_outtab.


    io_xml->read( EXPORTING iv_name = 'HEADER'
                  CHANGING cg_data = ls_header ).
    io_xml->read( EXPORTING iv_name = 'NAME32'
                  CHANGING cg_data = lv_name_32 ).
    io_xml->read( EXPORTING iv_name = 'NAME80'
                  CHANGING cg_data = lv_name_80 ).

    io_xml->read( EXPORTING iv_name = 'ASSIGNED_SWITCHES'
                  CHANGING cg_data = lt_assigned_switches ).
    io_xml->read( EXPORTING iv_name = 'DEPENDANCIES'
                  CHANGING cg_data = lt_dependancies ).
    io_xml->read( EXPORTING iv_name = 'CONTENT_KW'
                  CHANGING cg_data = ls_sfw_bfc_kw ).
    io_xml->read( EXPORTING iv_name = 'CONTENT_TC'
                  CHANGING cg_data = ls_sfw_bfc_tc ).
    io_xml->read( EXPORTING iv_name = 'CONTENT_RN'
                  CHANGING cg_data = ls_sfw_bfc_rn ).
    io_xml->read( EXPORTING iv_name = 'PARENT_BFS'
                  CHANGING cg_data = lt_parent_bfs ).

    lv_bf = ms_item-obj_name.
    TRY.
        lo_bf = cl_sfw_bf=>create_bf( lv_bf ).
      CATCH cx_pak_not_authorized cx_pak_invalid_state cx_pak_invalid_data.
        zcx_abapgit_exception=>raise( 'error in CL_SFW_BF=>CREATE_BF' ).
    ENDTRY.

    ls_header-author = sy-uname.
    ls_header-createdon = sy-datum.
    lo_bf->set_header_data( ls_header ).

    lo_bf->set_texts( p_32 = lv_name_32
                      p_80 = lv_name_80 ).

    lo_bf->set_assigned_switches( lt_assigned_switches ).
    lo_bf->set_excluded_bf( lt_dependancies ).
    lo_bf->set_content_data(
        im_sfw_bfc_kw = ls_sfw_bfc_kw
        im_sfw_bfc_rn = ls_sfw_bfc_rn
        im_sfw_bfc_tc = ls_sfw_bfc_tc ).
    lo_bf->set_parent_bfs( lt_parent_bfs ).

    set_default_package( iv_package ).
    tadir_insert( iv_package ).

    lo_bf->save_all( ).

    zcl_abapgit_objects_activation=>add_item( ms_item ).

  ENDMETHOD.