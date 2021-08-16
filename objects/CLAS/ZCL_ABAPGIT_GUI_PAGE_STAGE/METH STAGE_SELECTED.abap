  METHOD stage_selected.

    DATA:
      lt_fields TYPE tihttpnvp,
      ls_file   TYPE zif_abapgit_definitions=>ty_file.

    FIELD-SYMBOLS:
      <ls_file>   LIKE LINE OF ms_files-local,
      <ls_status> LIKE LINE OF ms_files-status,
      <ls_item>   LIKE LINE OF lt_fields.

    lt_fields = zcl_abapgit_html_action_utils=>parse_post_form_data( it_postdata ).

    IF lines( lt_fields ) = 0.
      zcx_abapgit_exception=>raise( 'process_stage_list: empty list' ).
    ENDIF.

    CREATE OBJECT ro_stage.

    LOOP AT lt_fields ASSIGNING <ls_item>
      "Ignore Files that we don't want to stage, so any errors don't stop the staging process
      WHERE value <> zif_abapgit_definitions=>c_method-skip.

      zcl_abapgit_path=>split_file_location(
        EXPORTING
          iv_fullpath = <ls_item>-name
        IMPORTING
          ev_path     = ls_file-path
          ev_filename = ls_file-filename ).

      READ TABLE ms_files-status ASSIGNING <ls_status>
        WITH TABLE KEY
          path     = ls_file-path
          filename = ls_file-filename.
      IF sy-subrc <> 0.
* see https://github.com/abapGit/abapGit/issues/3073
        zcx_abapgit_exception=>raise( iv_text =
          |Unable to stage { ls_file-filename }. If the filename contains spaces, this is a known issue.| &&
          | Consider ignoring or staging the file at a later time.| ).
      ENDIF.

      CASE <ls_item>-value.
        WHEN zif_abapgit_definitions=>c_method-add.
          READ TABLE ms_files-local ASSIGNING <ls_file>
            WITH KEY file-path     = ls_file-path
                     file-filename = ls_file-filename.

          IF sy-subrc <> 0.
            zcx_abapgit_exception=>raise( |process_stage_list: unknown file { ls_file-path }{ ls_file-filename }| ).
          ENDIF.

          ro_stage->add( iv_path     = <ls_file>-file-path
                         iv_filename = <ls_file>-file-filename
                         is_status   = <ls_status>
                         iv_data     = <ls_file>-file-data ).
        WHEN zif_abapgit_definitions=>c_method-ignore.
          ro_stage->ignore( iv_path     = ls_file-path
                            iv_filename = ls_file-filename ).
        WHEN zif_abapgit_definitions=>c_method-rm.
          ro_stage->rm( iv_path     = ls_file-path
                        is_status   = <ls_status>
                        iv_filename = ls_file-filename ).
        WHEN zif_abapgit_definitions=>c_method-skip.
          " Do nothing
        WHEN OTHERS.
          zcx_abapgit_exception=>raise( |process_stage_list: unknown method { <ls_item>-value }| ).
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.