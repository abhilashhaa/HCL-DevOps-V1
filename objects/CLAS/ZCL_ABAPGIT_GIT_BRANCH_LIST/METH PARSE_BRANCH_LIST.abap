  METHOD parse_branch_list.

    DATA: lt_result            TYPE TABLE OF string,
          lv_hash              TYPE zif_abapgit_definitions=>ty_sha1,
          lv_name              TYPE string,
          lv_head_params       TYPE string,
          lv_char              TYPE c,
          lv_data              LIKE LINE OF lt_result,
          lv_current_row_index TYPE syst-tabix.

    FIELD-SYMBOLS: <ls_branch> LIKE LINE OF et_list.

    CLEAR: et_list, ev_head_symref.

    lv_data = skip_first_pkt( iv_data ).
    SPLIT lv_data AT zif_abapgit_definitions=>c_newline INTO TABLE lt_result.

    LOOP AT lt_result INTO lv_data.
      lv_current_row_index = sy-tabix.

      IF sy-tabix = 1 AND strlen( lv_data ) > 49.
        lv_hash = lv_data+8.
        lv_name = lv_data+49.
        lv_char = zcl_abapgit_git_utils=>get_null( ).

        SPLIT lv_name AT lv_char INTO lv_name lv_head_params.
        ev_head_symref = parse_head_params( lv_head_params ).
      ELSEIF sy-tabix > 1 AND strlen( lv_data ) > 45.
        lv_hash = lv_data+4.
        lv_name = lv_data+45.
      ELSEIF sy-tabix = 1 AND strlen( lv_data ) = 8 AND lv_data(8) = '00000000'.
        zcx_abapgit_exception=>raise( 'No branches, create branch manually by adding file' ).
      ELSE.
        CONTINUE.
      ENDIF.

      ASSERT lv_name IS NOT INITIAL.

      APPEND INITIAL LINE TO et_list ASSIGNING <ls_branch>.
      <ls_branch>-sha1         = lv_hash.
      <ls_branch>-name         = lv_name.
      <ls_branch>-display_name = get_display_name( lv_name ).
      <ls_branch>-type         = get_type( iv_branch_name       = lv_name
                                           it_result            = lt_result
                                           iv_current_row_index = lv_current_row_index ).
      IF <ls_branch>-name = zif_abapgit_definitions=>c_head_name OR <ls_branch>-name = ev_head_symref.
        <ls_branch>-is_head = abap_true.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.