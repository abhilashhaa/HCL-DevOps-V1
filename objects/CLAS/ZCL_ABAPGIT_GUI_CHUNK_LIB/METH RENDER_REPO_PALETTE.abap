  METHOD render_repo_palette.

    DATA li_repo_srv TYPE REF TO zif_abapgit_repo_srv.
    DATA lt_repo_list TYPE zif_abapgit_persistence=>tt_repo.
    DATA lv_repo_json TYPE string.
    DATA lv_size TYPE i.
    DATA lo_repo TYPE REF TO zcl_abapgit_repo.
    FIELD-SYMBOLS <ls_repo> LIKE LINE OF lt_repo_list.

    li_repo_srv = zcl_abapgit_repo_srv=>get_instance( ).
    lt_repo_list = zcl_abapgit_persist_factory=>get_repo( )->list( ).
    lv_size = lines( lt_repo_list ).

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( 'var repoCatalog = [' ). " Maybe separate this into another method if needed in more places
    LOOP AT lt_repo_list ASSIGNING <ls_repo>.
      lo_repo = li_repo_srv->get( <ls_repo>-key ). " inefficient
      lv_repo_json = |\{ key: "{ <ls_repo>-key
        }", isOffline: "{ <ls_repo>-offline
        }", displayName: "{ lo_repo->get_name( ) }"  \}|.
      IF sy-tabix < lv_size.
        lv_repo_json = lv_repo_json && ','.
      ENDIF.
      ri_html->add( lv_repo_json ).
    ENDLOOP.
    ri_html->add( '];' ).

    ri_html->add( |var gGoRepoPalette = new CommandPalette(createRepoCatalogEnumerator(repoCatalog, "{
      iv_action }"), \{| ).
    ri_html->add( '  toggleKey: "F2",' ).
    ri_html->add( '  hotkeyDescription: "Go to repo ..."' ).
    ri_html->add( '});' ).

  ENDMETHOD.