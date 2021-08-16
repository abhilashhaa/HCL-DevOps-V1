  METHOD register_deferred_script.
    gui_services( )->get_html_parts( )->add_part(
      iv_collection = c_html_parts-scripts
      ii_part       = ii_part ).
  ENDMETHOD.