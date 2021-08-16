  METHOD fetch_repo_by_url.

    DATA li_pulls_json TYPE REF TO zif_abapgit_ajson_reader.
    DATA lv_pull_url TYPE string.
    DATA li_response TYPE REF TO zif_abapgit_http_response.

    li_response        = mi_http_agent->request( iv_repo_url ).
    rs_info-repo_json  = li_response->json( ).
    li_response->headers( ). " for debug

    lv_pull_url        = clean_url( rs_info-repo_json->get( '/pulls_url' ) ).
    li_pulls_json      = mi_http_agent->request( lv_pull_url )->json( ).
    rs_info-pulls      = convert_list( li_pulls_json ).

  ENDMETHOD.