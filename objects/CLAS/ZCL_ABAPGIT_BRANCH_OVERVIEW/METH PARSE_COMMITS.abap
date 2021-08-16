  METHOD parse_commits.

    DATA: ls_commit LIKE LINE OF mt_commits,
          lt_body   TYPE STANDARD TABLE OF string WITH DEFAULT KEY,
          ls_raw    TYPE zcl_abapgit_git_pack=>ty_commit.

    FIELD-SYMBOLS: <ls_object> LIKE LINE OF it_objects,
                   <lv_body>   TYPE string.


    LOOP AT it_objects ASSIGNING <ls_object> USING KEY type
        WHERE type = zif_abapgit_definitions=>c_type-commit.
      ls_raw = zcl_abapgit_git_pack=>decode_commit( <ls_object>-data ).

      CLEAR ls_commit.
      ls_commit-sha1 = <ls_object>-sha1.
      ls_commit-parent1 = ls_raw-parent.
      ls_commit-parent2 = ls_raw-parent2.

      SPLIT ls_raw-body AT zif_abapgit_definitions=>c_newline INTO TABLE lt_body.

      READ TABLE lt_body WITH KEY table_line = ' -----END PGP SIGNATURE-----' TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        DELETE lt_body TO sy-tabix.
        DELETE lt_body TO 2.
      ENDIF.

      READ TABLE lt_body INDEX 1 INTO ls_commit-message.  "#EC CI_SUBRC
      " The second line is always empty. Therefore we omit it.
      LOOP AT lt_body ASSIGNING <lv_body>
                      FROM 3.
        INSERT <lv_body> INTO TABLE ls_commit-body.
      ENDLOOP.

      zcl_abapgit_utils=>extract_author_data(
        EXPORTING
          iv_author = ls_raw-author
        IMPORTING
          ev_author = ls_commit-author
          ev_email  = ls_commit-email
          ev_time   = ls_commit-time ).

      APPEND ls_commit TO rt_commits.

    ENDLOOP.

  ENDMETHOD.