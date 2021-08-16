  METHOD branch_list.

    DATA: lv_data TYPE string.
    DATA: lv_expected_content_type TYPE string.

    eo_client = zcl_abapgit_http=>create_by_url(
      iv_url     = iv_url
      iv_service = iv_service ).

    lv_expected_content_type = c_smart_response_check-get_refs-content_type.
    REPLACE '<service>' IN lv_expected_content_type WITH iv_service.

    eo_client->check_smart_response(
        iv_expected_content_type = lv_expected_content_type
        iv_content_regex         = c_smart_response_check-get_refs-content_regex ).

    lv_data = eo_client->get_cdata( ).

    CREATE OBJECT eo_branch_list
      EXPORTING
        iv_data = lv_data.

  ENDMETHOD.