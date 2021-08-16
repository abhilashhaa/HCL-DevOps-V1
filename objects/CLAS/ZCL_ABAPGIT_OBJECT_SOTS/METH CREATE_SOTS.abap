  METHOD create_sots.

    " Reimplementation of SOTR_STRING_CREATE_CONCEPT because we can't supply
    " concept and it would then be generated.

    DATA: lv_subrc                 TYPE sy-subrc,
          lv_source_langu          TYPE spras,
          ls_header                TYPE btfr_head,
          lv_flag_is_string        TYPE btfr_flag VALUE abap_true,
          lt_text_tab              TYPE sotr_text_tt,
          lv_concept_default       TYPE sotr_conc,
          lt_entries               TYPE sotr_textl_tt,
          lv_concept               LIKE is_sots-header-concept,
          lv_flag_correction_entry TYPE abap_bool VALUE abap_true.

    lt_entries = is_sots-entries.

    ls_header-paket          = iv_package.
    ls_header-crea_lan       = mv_language.
    ls_header-alias_name     = is_sots-header-alias_name.
    lv_source_langu          = mv_language.
    lv_concept               = is_sots-header-concept.

    PERFORM btfr_create
      IN PROGRAM saplsotr_db_string
      USING iv_object
            lv_source_langu
            lv_flag_correction_entry
            lv_flag_is_string
      CHANGING lt_text_tab
               lt_entries
               ls_header
               lv_concept
               lv_concept_default
               lv_subrc.

    CASE lv_subrc.
      WHEN 1.
        zcx_abapgit_exception=>raise( |No entry found| ).
      WHEN 2.
        zcx_abapgit_exception=>raise( |OTR concept not found| ).
      WHEN 3.
        zcx_abapgit_exception=>raise( |Enter a permitted object type| ).
      WHEN 4.
        zcx_abapgit_exception=>raise( |The concept will be created in the non-original system| ).
      WHEN 5.
        zcx_abapgit_exception=>raise( |Invalid alias| ).
      WHEN 6.
        zcx_abapgit_exception=>raise( |No correction entry has been created| ).
      WHEN 7.
        zcx_abapgit_exception=>raise( |Error in database operation| ).
      WHEN 9.
        zcx_abapgit_exception=>raise( |Action canceled by user| ).
    ENDCASE.

  ENDMETHOD.