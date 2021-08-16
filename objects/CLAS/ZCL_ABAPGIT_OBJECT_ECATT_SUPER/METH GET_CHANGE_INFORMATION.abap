  METHOD get_change_information.

    DATA: li_document    TYPE REF TO if_ixml_document,
          lv_xml         TYPE xstring,
          lo_download    TYPE REF TO cl_apl_ecatt_download,
          lv_object_type TYPE etobj_type.

    lo_download = get_download( ).

    lv_object_type = get_object_type( ).

    lv_xml = zcl_abapgit_ecatt_helper=>build_xml_of_object(
                 iv_object_name    = mv_object_name
                 iv_object_version = is_version_info-version
                 iv_object_type    = lv_object_type
                 io_download       = lo_download ).

    li_document = cl_ixml_80_20=>parse_to_document( stream_xstring = lv_xml ).

    rs_change_information-ldate = get_changed_date( li_document ).
    rs_change_information-ltime = get_changed_time( li_document ).
    rs_change_information-luser = get_changed_by_user( li_document ).

  ENDMETHOD.