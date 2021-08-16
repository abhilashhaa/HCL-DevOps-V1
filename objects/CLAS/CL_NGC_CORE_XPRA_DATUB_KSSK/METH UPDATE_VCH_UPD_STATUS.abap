METHOD update_vch_upd_status.

  DATA:
    lv_empty_exists_in_ausp TYPE i,
    lt_vch_upd_status       TYPE STANDARD TABLE OF vch_upd_status.

  FIELD-SYMBOLS:
    <ls_vch_upd_status>     LIKE LINE OF lt_vch_upd_status.

  " First of all, let's see if both AUSP and KSSK are properly filled.
  SELECT SINGLE 1 INTO @lv_empty_exists_in_ausp FROM ausp CLIENT SPECIFIED
    WHERE mandt = @mv_client AND datub = '00000000'.

  " Get the current state
  SELECT * FROM vch_upd_status CLIENT SPECIFIED INTO TABLE @lt_vch_upd_status
    WHERE mandt = @mv_client AND maintenance_type = @if_vch_const=>gs_c_maintenance_type-class.

  IF lt_vch_upd_status IS INITIAL.
    " Ok, we have to create a new entry for 'CLS'
    APPEND INITIAL LINE TO lt_vch_upd_status ASSIGNING <ls_vch_upd_status>.
    <ls_vch_upd_status>-created_on         = sy-datum.
    <ls_vch_upd_status>-created_by         = sy-uname.
    <ls_vch_upd_status>-mandt              = mv_client.
    <ls_vch_upd_status>-maintenance_type   = if_vch_const=>gs_c_maintenance_type-class.
  ELSE.
    " We just have to update 'CLS'
    ASSIGN lt_vch_upd_status[ 1 ] TO <ls_vch_upd_status>.
    <ls_vch_upd_status>-changed_on         = sy-datum.
    <ls_vch_upd_status>-changed_by         = sy-uname.
  ENDIF.

  IF lv_empty_exists_in_ausp NE 1 AND iv_set EQ abap_true.
    " So both KSSK and AUSP are properly filled
    <ls_vch_upd_status>-maintenance_status = if_vch_const=>gs_c_maintenance_status-executed.
  ELSE.
    " So KSSK or AUSP is NOT properly filled
    <ls_vch_upd_status>-maintenance_status = if_vch_const=>gs_c_maintenance_status-not_executed.
  ENDIF.

  MODIFY vch_upd_status CLIENT SPECIFIED FROM TABLE lt_vch_upd_status.
  CALL FUNCTION 'DB_COMMIT'.

ENDMETHOD.