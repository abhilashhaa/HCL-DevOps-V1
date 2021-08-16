  METHOD render_content.

    DATA: lv_data    TYPE zif_abapgit_persistence=>ty_content-data_str,
          lo_toolbar TYPE REF TO zcl_abapgit_html_toolbar.

    TRY.
        lv_data = zcl_abapgit_persistence_db=>get_instance( )->read(
          iv_type  = ms_key-type
          iv_value = ms_key-value ).
      CATCH zcx_abapgit_not_found ##NO_HANDLER.
    ENDTRY.

    zcl_abapgit_persistence_db=>get_instance( )->lock(
      iv_type  = ms_key-type
      iv_value = ms_key-value ).

    lv_data = escape( val    = zcl_abapgit_xml_pretty=>print( lv_data )
                      format = cl_abap_format=>e_html_attr ).

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    CREATE OBJECT lo_toolbar.
    lo_toolbar->add( iv_act = 'submitFormById(''db_form'');'
                     iv_txt = 'Save'
                     iv_typ = zif_abapgit_html=>c_action_type-onclick
                     iv_opt = zif_abapgit_html=>c_html_opt-strong ).

    ri_html->add( '<div class="db_entry">' ).

    " Banners & Toolbar
    ri_html->add( '<table class="toolbar"><tr><td>' ).
    ri_html->add( zcl_abapgit_gui_page_db_dis=>render_record_banner( ms_key ) ).
    ri_html->add( '</td><td>' ).
    ri_html->add( lo_toolbar->render( iv_right = abap_true ) ).
    ri_html->add( '</td></tr></table>' ).

    " Form
    ri_html->add( |<form id="db_form" method="post" action="sapevent:{ c_action-update }">| ).
    ri_html->add( |<input type="hidden" name="type" value="{ ms_key-type }">| ).
    ri_html->add( |<input type="hidden" name="value" value="{ ms_key-value }">| ).
    ri_html->add( |<textarea rows="20" cols="100" name="xmldata">{ lv_data }</textarea>| ).
    ri_html->add( '</form>' ).

    ri_html->add( '</div>' ). "db_entry

  ENDMETHOD.