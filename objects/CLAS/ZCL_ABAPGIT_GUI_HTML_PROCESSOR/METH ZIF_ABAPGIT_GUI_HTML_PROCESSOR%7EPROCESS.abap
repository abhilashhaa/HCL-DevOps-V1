  METHOD zif_abapgit_gui_html_processor~process.

    DATA lo_css_processor TYPE REF TO zcl_abapgit_gui_css_processor.
    DATA lt_css_urls TYPE string_table.
    DATA lv_css_build TYPE string.

    FIELD-SYMBOLS <lv_url> LIKE LINE OF lt_css_urls.

    patch_html(
      EXPORTING
        iv_html = iv_html
      IMPORTING
        ev_html = rv_html
        et_css_urls = lt_css_urls ).

    IF lines( lt_css_urls ) > 0.
      CREATE OBJECT lo_css_processor
        EXPORTING
          ii_asset_manager = mi_asset_man.

      LOOP AT lt_css_urls ASSIGNING <lv_url>.
        lo_css_processor->add_file( <lv_url> ).
      ENDLOOP.

      lv_css_build = lo_css_processor->process( ).

      ii_gui_services->cache_asset(
        iv_url     = |{ c_css_build_name }|
        iv_type    = 'text'
        iv_subtype = 'css'
        iv_text    = lv_css_build ).
    ENDIF.

  ENDMETHOD.