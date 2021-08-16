  METHOD a_clfnclasscharc_get_entityset.

    DATA lt_entityset TYPE cl_api_clfn_class_mpc=>tt_a_clfnclasscharcforkeydatet.

    TEST-SEAM classcharc_get_entityset.
      super->a_clfnclasscharc_get_entityset(
        EXPORTING
          iv_entity_name           = iv_entity_name
          iv_entity_set_name       = iv_entity_set_name
          iv_source_name           = iv_source_name
          it_filter_select_options = it_filter_select_options
          is_paging                = is_paging
          it_key_tab               = it_key_tab
          it_navigation_path       = it_navigation_path
          it_order                 = it_order
          iv_filter_string         = iv_filter_string
          iv_search_string         = iv_search_string
          io_tech_request_context  = io_tech_request_context
        IMPORTING
          et_entityset             = et_entityset
          es_response_context      = es_response_context ).
    END-TEST-SEAM.

    SORT et_entityset ASCENDING BY classinternalid ancestorclassinternalid.

    LOOP AT et_entityset ASSIGNING FIELD-SYMBOL(<ls_entity>).
      IF <ls_entity>-ancestorclassinternalid = <ls_entity>-classinternalid.
        APPEND <ls_entity> TO lt_entityset.
      ENDIF.
    ENDLOOP.

    SORT lt_entityset ASCENDING BY classinternalid originalcharcinternalid.
    LOOP AT et_entityset ASSIGNING <ls_entity>.
      READ TABLE lt_entityset BINARY SEARCH TRANSPORTING NO FIELDS
                              WITH KEY classinternalid         = <ls_entity>-classinternalid
                                       originalcharcinternalid = <ls_entity>-originalcharcinternalid.
      IF sy-subrc <> 0.
        INSERT <ls_entity> INTO lt_entityset INDEX sy-tabix.
      ENDIF.
    ENDLOOP.

    et_entityset = lt_entityset.

  ENDMETHOD.