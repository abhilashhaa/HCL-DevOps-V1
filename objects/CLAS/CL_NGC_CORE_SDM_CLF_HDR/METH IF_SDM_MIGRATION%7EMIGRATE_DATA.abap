  METHOD if_sdm_migration~migrate_data.

    " Migrate data that qualifies IT_FILTER_CONDITION. (in current client!)

    DATA:
      lt_data      TYPE tt_clf_hdr,
      lv_where_str TYPE string,
      lv_recs      TYPE i.

    " Convert the package selection criteria into a WHERE clause.
    lv_where_str = NEW cl_shdb_pfw_selset( it_selset = it_filter_condition )->get_where_clause( ).

    " All cases except status=4.
    " This status is handled separately, because the data in case 4 should be checked for inconsistencies.
    IF cl_abap_dbfeatures=>use_features( requested_features = VALUE #( ( cl_abap_dbfeatures=>modify_from_select ) ) ).
      MODIFY clf_hdr FROM (
        SELECT FROM p_clfnsdmclfhdr
        FIELDS obtab, objek, mafid, klart, objekp, cuobj, tstmp_i, user_i, tstmp_c, user_c
        WHERE (lv_where_str)                           "#EC CI_DYNWHERE
          AND sdm_status >= @mc_sdm_status-clf_hdr_exist_objekp_unfilled-single
          AND sdm_status <= @mc_sdm_status-clf_hdr_exist_objekp_unfilled-multi
      ) ##NULL_VALUES ##DB_FEATURE_MODE[MODIFY_FROM_SELECT].
      lv_recs += sy-dbcnt.

      MODIFY clf_hdr FROM (
        SELECT FROM p_clfnsdmclfhdr
        FIELDS obtab, objek, mafid, klart, objekp, cuobj, tstmp_i, @sy-uname AS user_i, tstmp_c, user_c
        WHERE (lv_where_str)                           "#EC CI_DYNWHERE
          AND sdm_status >= @mc_sdm_status-clf_hdr_non_exist-single
          AND sdm_status <= @mc_sdm_status-clf_hdr_non_exist-class
          AND sdm_status <> @mc_sdm_status-clf_hdr_non_exist-multi
      ) ##NULL_VALUES ##DB_FEATURE_MODE[MODIFY_FROM_SELECT].
      lv_recs += sy-dbcnt.
    ELSE.
      SELECT FROM p_clfnsdmclfhdr
        FIELDS obtab, objek, mafid, klart, objekp, cuobj, tstmp_i, user_i, tstmp_c, user_c
        WHERE (lv_where_str)                           "#EC CI_DYNWHERE
          AND sdm_status >= @mc_sdm_status-clf_hdr_exist_objekp_unfilled-single
          AND sdm_status <= @mc_sdm_status-clf_hdr_exist_objekp_unfilled-multi
        INTO CORRESPONDING FIELDS OF TABLE @lt_data ##TOO_MANY_ITAB_FIELDS.

      SELECT FROM p_clfnsdmclfhdr
        FIELDS obtab, objek, mafid, klart, objekp, cuobj, tstmp_i, @sy-uname AS user_i, tstmp_c, user_c
        WHERE (lv_where_str)                           "#EC CI_DYNWHERE
          AND sdm_status >= @mc_sdm_status-clf_hdr_non_exist-single
          AND sdm_status <= @mc_sdm_status-clf_hdr_non_exist-class
          AND sdm_status <> @mc_sdm_status-clf_hdr_non_exist-multi
        APPENDING CORRESPONDING FIELDS OF TABLE @lt_data ##TOO_MANY_ITAB_FIELDS.

      IF lines( lt_data ) > 0.
        MODIFY clf_hdr FROM TABLE lt_data.
        lv_recs = sy-dbcnt.
      ENDIF.
    ENDIF.

    " Status=4.
    " This status is handled separately, because the data in this case come from table INOB,
    " which may have multiple CUOBJs for a BO. In these cases only one CUOBJ should be kept.
    SELECT FROM p_clfnsdmclfhdr
      FIELDS obtab, objek, mafid, klart, objekp, cuobj, tstmp_i, @sy-uname AS user_i, tstmp_c, user_c
      WHERE (lv_where_str)                             "#EC CI_DYNWHERE
        AND sdm_status = @mc_sdm_status-clf_hdr_non_exist-multi
      INTO CORRESPONDING FIELDS OF TABLE @lt_data ##TOO_MANY_ITAB_FIELDS.

    IF lines( lt_data ) > 0.
      me->inob_inconsistency( CHANGING ct_clf_hdr = lt_data ).

      MODIFY clf_hdr FROM TABLE lt_data.
      lv_recs += sy-dbcnt.
    ENDIF.

    MESSAGE i100(sdmi) WITH | { lv_recs } records converted in client { sy-mandt } | INTO me->mo_logger->mv_logmsg ##NO_TEXT.
    me->mo_logger->add_message( ).

    IF me->mv_test_mode = abap_true.
      ROLLBACK CONNECTION default.                     "#EC CI_ROLLBACK
    ENDIF.

    COMMIT WORK.

  ENDMETHOD.