  METHOD source_apack_replacement.

    DATA: lv_clsname TYPE seoclsname.
    FIELD-SYMBOLS: <lv_source> LIKE LINE OF ct_source.

    lv_clsname = ms_item-obj_name.
    SELECT COUNT(*)
      FROM seometarel
      WHERE clsname    = lv_clsname
        AND refclsname = 'ZIF_APACK_MANIFEST'
        AND version    = '1'.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    LOOP AT ct_source ASSIGNING <lv_source>.

      FIND FIRST OCCURRENCE OF REGEX '^\s*INTERFACES(:| )\s*zif_apack_manifest\s*.' IN <lv_source>.
      IF sy-subrc = 0.
        REPLACE FIRST OCCURRENCE OF 'zif_apack_manifest' IN <lv_source> WITH 'if_apack_manifest' IGNORING CASE.

        REPLACE ALL OCCURRENCES OF 'zif_apack_manifest~descriptor' IN TABLE ct_source
                              WITH 'if_apack_manifest~descriptor' IGNORING CASE.

        EXIT.
      ENDIF.

      FIND FIRST OCCURRENCE OF REGEX '^\s*PROTECTED\s*SECTION\s*.' IN <lv_source>.
      IF sy-subrc = 0.
        EXIT.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.