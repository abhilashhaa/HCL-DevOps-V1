  METHOD zif_abapgit_object~deserialize.

    DATA: lo_switch    TYPE REF TO cl_sfw_sw,
          lv_switch_id TYPE sfw_switch_id,
          ls_header    TYPE sfw_switch,
          lv_name_32   TYPE sfw_name32,
          lv_name_80   TYPE sfw_name80,
          lt_parent_bf TYPE sfw_bf_sw_outtab,
          lt_conflicts TYPE sfw_confl_outtab.


    io_xml->read( EXPORTING iv_name = 'HEADER'
                  CHANGING cg_data = ls_header ).
    io_xml->read( EXPORTING iv_name = 'NAME32'
                  CHANGING cg_data = lv_name_32 ).
    io_xml->read( EXPORTING iv_name = 'NAME80'
                  CHANGING cg_data = lv_name_80 ).

    io_xml->read( EXPORTING iv_name = 'PARENT_BF'
                  CHANGING cg_data = lt_parent_bf ).
    io_xml->read( EXPORTING iv_name = 'CONFLICTS'
                  CHANGING cg_data = lt_conflicts ).

    lv_switch_id = ms_item-obj_name.
    TRY.
        lo_switch = cl_sfw_sw=>create_switch( lv_switch_id ).
      CATCH cx_pak_not_authorized cx_pak_invalid_state cx_pak_invalid_data.
        zcx_abapgit_exception=>raise( 'error in CL_SFW_SW=>CREATE_SWITCH' ).
    ENDTRY.

    ls_header-author = sy-uname.
    ls_header-createdon = sy-datum.
    lo_switch->set_header_data( ls_header ).

    lo_switch->set_texts( p_32 = lv_name_32
                          p_80 = lv_name_80 ).

    lo_switch->set_parent_bf( lt_parent_bf ).
    lo_switch->set_conflicts( lt_conflicts ).

    set_default_package( iv_package ).
    tadir_insert( iv_package ).

    lo_switch->save_all(
      EXCEPTIONS
        not_saved = 1
        OTHERS    = 2 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error in CL_SFW_SW->SAVE_ALL' ).
    ENDIF.

    zcl_abapgit_objects_activation=>add_item( ms_item ).

  ENDMETHOD.