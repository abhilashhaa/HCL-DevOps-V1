  METHOD replace_section_head_with_text.

    CASE cs_itf-tdline.
      WHEN gc_section_token-cause.
        cs_itf-tdline = gc_section_text-cause.
      WHEN gc_section_token-system_response.
        cs_itf-tdline = gc_section_text-system_response.
      WHEN gc_section_token-what_to_do.
        cs_itf-tdline = gc_section_text-what_to_do.
      WHEN gc_section_token-sys_admin.
        cs_itf-tdline = gc_section_text-sys_admin.
    ENDCASE.

  ENDMETHOD.