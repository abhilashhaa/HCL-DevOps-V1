  METHOD render_patch_head.

    ii_html->add( |<th class="patch">| ).
    ii_html->add_checkbox( |patch_file_{ get_normalized_fname_with_path( is_diff ) }| ).
    ii_html->add( '</th>' ).

  ENDMETHOD.