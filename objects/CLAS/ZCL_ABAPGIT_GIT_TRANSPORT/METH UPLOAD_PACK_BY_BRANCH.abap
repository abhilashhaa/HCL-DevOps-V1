  METHOD upload_pack_by_branch.

    DATA: lo_client   TYPE REF TO zcl_abapgit_http_client,
          lv_buffer   TYPE string,
          lv_xstring  TYPE xstring,
          lv_line     TYPE string,
          lv_pack     TYPE xstring,
          lt_branches TYPE zif_abapgit_definitions=>ty_git_branch_list_tt,
          lv_capa     TYPE string.

    FIELD-SYMBOLS: <ls_branch> LIKE LINE OF lt_branches.


    CLEAR: et_objects,
           ev_branch,
           eo_branch_list.

    find_branch(
      EXPORTING
        iv_url         = iv_url
        iv_service     = c_service-upload
        iv_branch_name = iv_branch_name
      IMPORTING
        eo_client      = lo_client
        eo_branch_list = eo_branch_list
        ev_branch      = ev_branch ).

    IF it_branches IS INITIAL.
      APPEND INITIAL LINE TO lt_branches ASSIGNING <ls_branch>.
      <ls_branch>-sha1 = ev_branch.
    ELSE.
      lt_branches = it_branches.
    ENDIF.

    lo_client->set_headers( iv_url     = iv_url
                            iv_service = c_service-upload ).

    LOOP AT lt_branches FROM 1 ASSIGNING <ls_branch>.
      IF sy-tabix = 1.
        lv_capa = 'side-band-64k no-progress multi_ack'.
        lv_line = 'want' && ` ` && <ls_branch>-sha1
          && ` ` && lv_capa && zif_abapgit_definitions=>c_newline.
      ELSE.
        lv_line = 'want' && ` ` && <ls_branch>-sha1
          && zif_abapgit_definitions=>c_newline.
      ENDIF.
      lv_buffer = lv_buffer && zcl_abapgit_git_utils=>pkt_string( lv_line ).
    ENDLOOP.

    IF iv_deepen_level > 0.
      lv_buffer = lv_buffer && zcl_abapgit_git_utils=>pkt_string( |deepen { iv_deepen_level }|
        && zif_abapgit_definitions=>c_newline ).
    ENDIF.

    lv_buffer = lv_buffer
             && '0000'
             && '0009done' && zif_abapgit_definitions=>c_newline.

    lv_xstring = lo_client->send_receive_close( zcl_abapgit_convert=>string_to_xstring_utf8( lv_buffer ) ).

    parse( IMPORTING ev_pack = lv_pack
           CHANGING cv_data = lv_xstring ).

    IF lv_pack IS INITIAL.
      zcx_abapgit_exception=>raise( 'empty pack' ).
    ENDIF.

    et_objects = zcl_abapgit_git_pack=>decode( lv_pack ).

  ENDMETHOD.