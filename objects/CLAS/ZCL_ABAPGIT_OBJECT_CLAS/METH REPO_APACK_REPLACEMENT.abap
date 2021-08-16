  METHOD repo_apack_replacement.

    FIELD-SYMBOLS: <lv_source> LIKE LINE OF ct_source.

    LOOP AT ct_source ASSIGNING <lv_source>.

      FIND FIRST OCCURRENCE OF REGEX '^\s*INTERFACES(:| )\s*if_apack_manifest\s*.' IN <lv_source>.
      IF sy-subrc = 0.
        REPLACE FIRST OCCURRENCE OF 'if_apack_manifest' IN <lv_source> WITH 'zif_apack_manifest' IGNORING CASE.

        REPLACE ALL OCCURRENCES OF 'if_apack_manifest~descriptor' IN TABLE ct_source
                              WITH 'zif_apack_manifest~descriptor' IGNORING CASE.

        EXIT.
      ENDIF.

      FIND FIRST OCCURRENCE OF REGEX '^\s*PROTECTED\s*SECTION\s*.' IN <lv_source>.
      IF sy-subrc = 0.
        EXIT.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.