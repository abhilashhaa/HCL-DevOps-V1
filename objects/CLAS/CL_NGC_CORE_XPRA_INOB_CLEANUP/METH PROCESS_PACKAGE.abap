METHOD process_package.

  TYPES:
    BEGIN OF ltt_inconinob,
      mandt TYPE symandt,
      cuobj TYPE cuobj,
    END OF ltt_inconinob.

  TYPES:
    ltty_inconinob TYPE STANDARD TABLE OF ltt_inconinob.

  DATA:
    lv_packsel_whr     TYPE string,
    lt_inconinob       TYPE ltty_inconinob,
    ltr_cuobj          TYPE ltt_cuobj_range,
    lv_lock_error      TYPE boole_d VALUE abap_false,
    lv_num_of_del_inob type int4 value 0.

  FIELD-SYMBOLS:
    <ls_packsel> TYPE if_shdb_pfw_package_provider=>ts_packsel.

  " now process the data in packages defined by package selection criteria
  LOOP AT it_packsel ASSIGNING <ls_packsel>.
    lv_lock_error = abap_false.
    lv_num_of_del_inob = 0.

    MESSAGE i036(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##MG_MISSING .
    cl_upgba_logger=>log->trace_single( ).

    TEST-SEAM combine_seltabs_seam.
      lv_packsel_whr = cl_shdb_pfw_seltab=>combine_seltabs( <ls_packsel>-selection ).
    END-TEST-SEAM.

    CLEAR: lt_inconinob.
    TEST-SEAM select_cds_seam.
      SELECT mandt, cuobj FROM (mv_inconinob_name)         "#EC CI_DYNTAB
        CLIENT SPECIFIED                                   "#EC CI_CLIENT
        WHERE (lv_packsel_whr)                           "#EC CI_DYNWHERE
        ORDER BY mandt, cuobj
        INTO TABLE @lt_inconinob.
    END-TEST-SEAM.
    IF sy-subrc = 0.
      lv_num_of_del_inob = lines( lt_inconinob ).
      CLEAR: ltr_cuobj.
      LOOP AT lt_inconinob ASSIGNING FIELD-SYMBOL(<ls_inconinob>).
        APPEND VALUE #( sign = 'I' option = 'EQ' low = <ls_inconinob>-cuobj ) TO ltr_cuobj.
      ENDLOOP.

      IF ltr_cuobj IS NOT INITIAL.
        " in on-premise we lock and unlock
        TEST-SEAM pp_lock_seam.
          IF cl_cos_utilities=>is_cloud( ) = abap_false.
            lv_lock_error = lock_entries( ltr_cuobj ).
          ENDIF.
        END-TEST-SEAM.

        IF lv_lock_error = abap_false.
          " remove the entries
          DELETE FROM inob CLIENT SPECIFIED WHERE mandt = @mv_client AND cuobj IN @ltr_cuobj. "#EC CI_CLIENT
        ELSE.
          " in case of error we don't convert this package, but continue with the next package
          CONTINUE.
        ENDIF.
      ENDIF.
    ENDIF.

    MESSAGE i037(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##MG_MISSING .
    cl_upgba_logger=>log->trace_single( ).

    CALL FUNCTION 'DB_COMMIT'.

    MESSAGE i010(ngc_core_db) WITH 'INOB' lv_num_of_del_inob INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    " in on-premise we lock and unlock
    TEST-SEAM pp_unlock_seam.
      IF cl_cos_utilities=>is_cloud( ) = abap_false.
        unlock_entries( ).
      ENDIF.
    END-TEST-SEAM.
  ENDLOOP.

ENDMETHOD.