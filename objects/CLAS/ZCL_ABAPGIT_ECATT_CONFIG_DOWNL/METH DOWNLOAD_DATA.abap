  METHOD download_data.

    " Downport

    mv_xml_stream = zcl_abapgit_ecatt_helper=>download_data( template_over_all ).

  ENDMETHOD.