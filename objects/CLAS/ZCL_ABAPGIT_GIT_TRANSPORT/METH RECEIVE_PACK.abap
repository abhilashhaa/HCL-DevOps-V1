  METHOD receive_pack.

    DATA: lo_client   TYPE REF TO zcl_abapgit_http_client,
          lv_cmd_pkt  TYPE string,
          lv_line     TYPE string,
          lv_tmp      TYPE xstring,
          lv_xstring  TYPE xstring,
          lv_string   TYPE string,
          lv_cap_list TYPE string,
          lv_buffer   TYPE string.


    find_branch(
      EXPORTING
        iv_url         = iv_url
        iv_service     = c_service-receive
        iv_branch_name = iv_branch_name
      IMPORTING
        eo_client      = lo_client ).

    lo_client->set_headers(
      iv_url     = iv_url
      iv_service = c_service-receive ).

    lv_cap_list = 'report-status'.

    lv_line = iv_old &&
              ` ` &&
              iv_new &&
              ` ` &&
              iv_branch_name &&
              zcl_abapgit_git_utils=>get_null( ) &&
              ` ` &&
              lv_cap_list &&
              zif_abapgit_definitions=>c_newline.
    lv_cmd_pkt = zcl_abapgit_git_utils=>pkt_string( lv_line ).

    lv_buffer = lv_cmd_pkt && '0000'.
    lv_tmp = zcl_abapgit_convert=>string_to_xstring_utf8( lv_buffer ).

    CONCATENATE lv_tmp iv_pack INTO lv_xstring IN BYTE MODE.

    lv_xstring = lo_client->send_receive_close( lv_xstring ).

* todo, this part should be changed, instead of looking at texts
* parse the reply and look for the "ng" not good indicator
    lv_string = zcl_abapgit_convert=>xstring_to_string_utf8( lv_xstring ).
    IF NOT lv_string CP '*unpack ok*'.
      zcx_abapgit_exception=>raise( 'unpack not ok' ).
    ELSEIF lv_string CP '*pre-receive hook declined*'.
      zcx_abapgit_exception=>raise( 'pre-receive hook declined' ).
    ELSEIF lv_string CP '*protected branch hook declined*'.
      zcx_abapgit_exception=>raise( 'protected branch hook declined' ).
    ELSEIF lv_string CP '*push declined due to email privacy*'.
      zcx_abapgit_exception=>raise( 'push declined due to email privacy' ).
    ELSEIF lv_string CP '*funny refname*'.
      zcx_abapgit_exception=>raise( 'funny refname' ).
    ELSEIF lv_string CP '*failed to update ref*'.
      zcx_abapgit_exception=>raise( 'failed to update ref' ).
    ELSEIF lv_string CP '*missing necessary objects*'.
      zcx_abapgit_exception=>raise( 'missing necessary objects' ).
    ELSEIF lv_string CP '*refusing to delete the current branch*'.
      zcx_abapgit_exception=>raise( 'branch delete not allowed' ).
    ELSEIF lv_string CP '*cannot lock ref*reference already exists*'.
      zcx_abapgit_exception=>raise( 'branch already exists' ).
    ELSEIF lv_string CP '*invalid committer*'.
      zcx_abapgit_exception=>raise( 'invalid committer' ).
    ENDIF.

  ENDMETHOD.