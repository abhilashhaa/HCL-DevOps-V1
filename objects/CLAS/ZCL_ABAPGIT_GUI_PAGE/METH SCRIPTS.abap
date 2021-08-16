  METHOD scripts.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    render_deferred_parts(
      ii_html          = ri_html
      iv_part_category = c_html_parts-scripts ).

    render_link_hints( ri_html ).
    render_command_palettes( ri_html ).

  ENDMETHOD.