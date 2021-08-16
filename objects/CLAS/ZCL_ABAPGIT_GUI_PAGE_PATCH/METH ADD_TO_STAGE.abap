  METHOD add_to_stage.

    DATA: lt_diff              TYPE zif_abapgit_definitions=>ty_diffs_tt,
          lv_something_patched TYPE abap_bool,
          ls_status            TYPE zif_abapgit_definitions=>ty_result,
          lv_patch             TYPE xstring,
          lo_git_add_patch     TYPE REF TO zcl_abapgit_git_add_patch.

    FIELD-SYMBOLS: <ls_diff_file> TYPE ty_file_diff.

    LOOP AT mt_diff_files ASSIGNING <ls_diff_file>.

      IF <ls_diff_file>-o_diff IS NOT BOUND.
        " When we deal with binary files we don't have a diff object.
        " There's nothing to do because they cannot be patched
        CONTINUE.
      ENDIF.

      lt_diff = <ls_diff_file>-o_diff->get( ).

      READ TABLE lt_diff TRANSPORTING NO FIELDS
                         WITH KEY patch_flag = abap_true.
      CHECK sy-subrc = 0.

      lv_something_patched = abap_true.

      CREATE OBJECT lo_git_add_patch
        EXPORTING
          it_diff = <ls_diff_file>-o_diff->get( ).

      lv_patch = lo_git_add_patch->get_patch_binary( ).

      IF <ls_diff_file>-lstate = 'D' AND are_all_lines_patched( lt_diff ) = abap_true.

        ls_status-lstate = zif_abapgit_definitions=>c_state-deleted.
        mo_stage->rm(
          iv_path     = <ls_diff_file>-path
          is_status   = ls_status
          iv_filename = <ls_diff_file>-filename ).

      ELSE.

        IF <ls_diff_file>-lstate = 'A' AND are_all_lines_patched( lt_diff ) = abap_true.
          ls_status-lstate = zif_abapgit_definitions=>c_state-added.
        ELSE.
          ls_status-lstate = zif_abapgit_definitions=>c_state-modified.
        ENDIF.

        mo_stage->add(
          iv_path     = <ls_diff_file>-path
          iv_filename = <ls_diff_file>-filename
          is_status   = ls_status
          iv_data     = lv_patch ).

      ENDIF.

    ENDLOOP.

    IF lv_something_patched = abap_false.
      zcx_abapgit_exception=>raise( |Nothing added| ).
    ENDIF.

  ENDMETHOD.