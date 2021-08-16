  METHOD zif_abapgit_object~deserialize.

    DATA: lv_tool     TYPE enhtooltype,
          li_enho     TYPE REF TO zif_abapgit_object_enho.

    IF zif_abapgit_object~exists( ) = abap_true.
      zif_abapgit_object~delete( iv_package ).
    ENDIF.

    io_xml->read( EXPORTING iv_name = 'TOOL'
                  CHANGING cg_data = lv_tool ).

    li_enho = factory( lv_tool ).

    li_enho->deserialize( ii_xml     = io_xml
                          iv_package = iv_package ).

    zcl_abapgit_sotr_handler=>create_sotr(
      iv_package = iv_package
      io_xml     = io_xml ).

    zcl_abapgit_objects_activation=>add_item( ms_item ).

  ENDMETHOD.