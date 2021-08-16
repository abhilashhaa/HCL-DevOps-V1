  METHOD get_normalized_fname_with_path.

    rv_filename = normalize_path( is_diff-path )
               && `_`
               && normalize_filename( is_diff-filename ).

  ENDMETHOD.