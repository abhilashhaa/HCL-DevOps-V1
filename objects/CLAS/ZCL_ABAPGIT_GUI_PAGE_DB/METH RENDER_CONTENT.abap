  METHOD render_content.

    DATA: lt_data    TYPE zif_abapgit_persistence=>tt_content,
          lv_action  TYPE string,
          lv_trclass TYPE string,
          lo_toolbar TYPE REF TO zcl_abapgit_html_toolbar.

    FIELD-SYMBOLS: <ls_data> LIKE LINE OF lt_data.


    lt_data = zcl_abapgit_persistence_db=>get_instance( )->list( ).

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div class="db_list">' ).
    ri_html->add( '<table class="db_tab">' ).

    " Header
    ri_html->add( '<thead>' ).
    ri_html->add( '<tr>' ).
    ri_html->add( '<th>Type</th>' ).
    ri_html->add( '<th>Key</th>' ).
    ri_html->add( '<th>Data</th>' ).
    ri_html->add( '<th></th>' ).
    ri_html->add( '</tr>' ).
    ri_html->add( '</thead>' ).
    ri_html->add( '<tbody>' ).

    " Lines
    LOOP AT lt_data ASSIGNING <ls_data>.
      CLEAR lv_trclass.
      IF sy-tabix = 1.
        lv_trclass = ' class="firstrow"'.
      ENDIF.

      lv_action  = zcl_abapgit_html_action_utils=>dbkey_encode( <ls_data> ).

      CREATE OBJECT lo_toolbar.
      lo_toolbar->add( iv_txt = 'Display'
                       iv_act = |{ zif_abapgit_definitions=>c_action-db_display }?{ lv_action }| ).
      lo_toolbar->add( iv_txt = 'Edit'
                       iv_act = |{ zif_abapgit_definitions=>c_action-db_edit }?{ lv_action }| ).
      lo_toolbar->add( iv_txt = 'Delete'
                       iv_act = |{ c_action-delete }?{ lv_action }| ).

      ri_html->add( |<tr{ lv_trclass }>| ).
      ri_html->add( |<td>{ <ls_data>-type }</td>| ).
      ri_html->add( |<td>{ <ls_data>-value }</td>| ).
      ri_html->add( |<td class="data">{ explain_content( <ls_data> ) }</td>| ).
      ri_html->add( '<td>' ).
      ri_html->add( lo_toolbar->render( ) ).
      ri_html->add( '</td>' ).
      ri_html->add( '</tr>' ).
    ENDLOOP.

    ri_html->add( '</tbody>' ).
    ri_html->add( '</table>' ).
    ri_html->add( '</div>' ).

  ENDMETHOD.