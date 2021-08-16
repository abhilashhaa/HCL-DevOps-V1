  METHOD prepare_tags_for_display.

    DATA: ls_tag_out LIKE LINE OF rt_tags_out.

    FIELD-SYMBOLS: <ls_tag> TYPE zif_abapgit_definitions=>ty_git_tag.

    LOOP AT it_tags ASSIGNING <ls_tag>.

      CLEAR: ls_tag_out.

      MOVE-CORRESPONDING <ls_tag> TO ls_tag_out.

      ls_tag_out-name = zcl_abapgit_git_tag=>remove_tag_prefix( ls_tag_out-name ).

      IF ls_tag_out-body IS NOT INITIAL.
        ls_tag_out-body_icon = |{ icon_display_text }|.
      ENDIF.

      INSERT ls_tag_out INTO TABLE rt_tags_out.

    ENDLOOP.

  ENDMETHOD.