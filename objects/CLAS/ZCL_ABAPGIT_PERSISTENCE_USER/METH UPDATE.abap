  METHOD update.

    DATA: lv_xml TYPE string.

    lv_xml = to_xml( is_user ).

    zcl_abapgit_persistence_db=>get_instance( )->modify(
      iv_type  = zcl_abapgit_persistence_db=>c_type_user
      iv_value = mv_user
      iv_data  = lv_xml ).

  ENDMETHOD.