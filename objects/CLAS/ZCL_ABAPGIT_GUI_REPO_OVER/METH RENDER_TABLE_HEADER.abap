  METHOD render_table_header.

    CLEAR mt_col_spec.

    _add_column(
      iv_tech_name = 'FAVORITE'
      iv_css_class = 'wmin' ).

    _add_column(
      iv_tech_name = 'TYPE'
      iv_css_class = 'wmin' ).

    _add_column(
      iv_tech_name = 'NAME'
      iv_display_name = 'Name' ).

    _add_column(
      iv_tech_name = 'URL'
      iv_display_name = 'Url' ).

    _add_column(
      iv_tech_name = 'PACKAGE'
      iv_display_name = 'Package' ).

    _add_column(
      iv_tech_name = 'BRANCH'
      iv_display_name = 'Branch' ).

    _add_column(
      iv_tech_name = 'DESERIALIZED_BY'
      iv_display_name = 'Deserialized by'
      iv_css_class = 'ro-detail' ).

    _add_column(
      iv_tech_name = 'DESERIALIZED_AT'
      iv_display_name = 'Deserialized at'
      iv_css_class = 'ro-detail'
      iv_add_tz = abap_true ).

    _add_column(
      iv_tech_name = 'CREATED_BY'
      iv_display_name = 'Created by'
      iv_css_class = 'ro-detail' ).


    _add_column(
      iv_tech_name = 'CREATED_AT'
      iv_display_name = 'Created at'
      iv_css_class = 'ro-detail'
      iv_add_tz = abap_true ).

    _add_column(
      iv_tech_name = 'KEY'
      iv_display_name = 'Key'
      iv_css_class = 'ro-detail' ).

    _add_column(
      iv_tech_name = 'ACTION'
      iv_display_name = 'Action'
      iv_css_class = 'ro-action' ).

    _add_column(
      iv_tech_name = 'GO'
      iv_css_class = 'ro-go' ).

    ii_html->add( |<thead>| ).
    ii_html->add( |<tr>| ).

    ii_html->add( zcl_abapgit_gui_chunk_lib=>render_order_by_header_cells(
                      it_col_spec         = mt_col_spec
                      iv_order_by         = mv_order_by
                      iv_order_descending = mv_order_descending ) ).

    ii_html->add( '</tr>' ).
    ii_html->add( '</thead>' ).

  ENDMETHOD.