  METHOD render_beacon_begin_of_row.

    mv_section_count = mv_section_count + 1.

    ii_html->add( |<th class="patch">| ).
    ii_html->add_checkbox( iv_id = |patch_section_{ get_normalized_fname_with_path( is_diff ) }_{ mv_section_count }| ).
    ii_html->add( '</th>' ).

  ENDMETHOD.