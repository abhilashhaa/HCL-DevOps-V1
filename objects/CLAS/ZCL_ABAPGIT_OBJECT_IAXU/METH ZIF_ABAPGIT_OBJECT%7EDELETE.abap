  METHOD zif_abapgit_object~delete.

    DATA: lo_xml_api TYPE REF TO object,
          ls_name    TYPE iacikeyt.

    ls_name = ms_item-obj_name.

    w3_api_load( EXPORTING is_name    = ls_name
                 IMPORTING eo_xml_api = lo_xml_api ).

    w3_api_set_changeable( io_xml_api    = lo_xml_api
                           iv_changeable = abap_true ).

    w3_api_delete( io_xml_api = lo_xml_api ).

    w3_api_save( io_xml_api = lo_xml_api ).

  ENDMETHOD.