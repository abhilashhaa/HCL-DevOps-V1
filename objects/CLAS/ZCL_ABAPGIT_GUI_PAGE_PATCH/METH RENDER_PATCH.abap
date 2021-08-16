  METHOD render_patch.

    CONSTANTS:
      BEGIN OF lc_css_class,
        patch TYPE string VALUE `patch`,
      END OF lc_css_class.

    DATA:
      lv_id                TYPE string,
      lv_patched           TYPE abap_bool,
      lv_is_patch_possible TYPE abap_bool.

    lv_patched = get_diff_object( iv_filename )->is_line_patched( iv_index ).

    lv_is_patch_possible = is_patch_line_possible( is_diff_line ).

    IF lv_is_patch_possible = abap_true.

      lv_id = |{ iv_filename }_{ mv_section_count }_{ iv_index }|.

      ii_html->add( |<td class="{ lc_css_class-patch }">| ).
      ii_html->add_checkbox(
          iv_id      = |patch_line_{ lv_id }|
          iv_checked = lv_patched ).
      ii_html->add( |</td>| ).

    ELSE.

      ii_html->add( |<td class="{ lc_css_class-patch }">| ).
      ii_html->add( |</td>| ).

    ENDIF.

  ENDMETHOD.