  METHOD start_staging.

    apply_patch_from_form_fields( it_postdata ).
    add_to_stage( ).

  ENDMETHOD.