  METHOD zif_abapgit_object~deserialize.
* see function group SUSA

    DATA: ls_tobc       TYPE tobc,
          lv_objectname TYPE e071-obj_name,
          ls_tobct      TYPE tobct.


    io_xml->read( EXPORTING iv_name = 'TOBC'
                  CHANGING cg_data = ls_tobc ).
    io_xml->read( EXPORTING iv_name = 'TOBCT'
                  CHANGING cg_data = ls_tobct ).

    tadir_insert( iv_package ).

    lv_objectname = ms_item-obj_name.
    CALL FUNCTION 'SUSR_COMMEDITCHECK'
      EXPORTING
        objectname      = lv_objectname
        transobjecttype = transobjecttype_class.

    INSERT tobc FROM ls_tobc.                             "#EC CI_SUBRC
* ignore sy-subrc as all fields are key fields

    MODIFY tobct FROM ls_tobct.                           "#EC CI_SUBRC
    ASSERT sy-subrc = 0.

  ENDMETHOD.