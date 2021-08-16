  METHOD render_dot_abapgit_reqs.

    CONSTANTS: lc_requirement_edit_min_count TYPE i VALUE 5.
    DATA lv_req_index TYPE i.
    DATA lv_requirement_count TYPE i.
    DATA lt_requirements LIKE it_requirements.
    FIELD-SYMBOLS <ls_requirement> TYPE zif_abapgit_dot_abapgit=>ty_requirement.

    lt_requirements      = it_requirements.
    lv_requirement_count = lines( lt_requirements ).
    IF lv_requirement_count < lc_requirement_edit_min_count.
      DO - lv_requirement_count + lc_requirement_edit_min_count TIMES.
        APPEND INITIAL LINE TO lt_requirements.
      ENDDO.
    ENDIF.

    ii_html->add( '<h3>Requirements</h3>' ).
    ii_html->add( '<table class="settings-package-requirements" id="requirement-tab">' ).
    ii_html->add( '<tr><th>Software Component</th><th>Min. Release</th><th>Min. Patch</th></tr>' ).

    LOOP AT lt_requirements ASSIGNING <ls_requirement>.
      lv_req_index = sy-tabix.

      ii_html->add( '<tr>' ).
      ii_html->add( |<td><input name="req_com_{ lv_req_index }" maxlength=30 type="text" | &&
                    |value="{ <ls_requirement>-component }"></td>| ).
      ii_html->add( |<td><input name="req_rel_{ lv_req_index }" maxlength=10 type="text" | &&
                    |value="{ <ls_requirement>-min_release }"></td>| ).
      ii_html->add( |<td><input name="req_pat_{ lv_req_index }" maxlength=10 type="text" | &&
                    |value="{ <ls_requirement>-min_patch }"></td>| ).
      ii_html->add( '</tr>' ).
    ENDLOOP.

    ii_html->add( '</table>' ).

  ENDMETHOD.