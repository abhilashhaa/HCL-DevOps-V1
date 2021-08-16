*&---------------------------------------------------------------------*
*& Report RNGC_CORE_CL_HIER_GENERATE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT rngc_core_cls_hier_generate.

DATA:
  lv_clint           TYPE clint,
  lv_start_time      TYPE i,
  lv_end_time        TYPE i,
  lv_duration        TYPE p,
  lv_size_before     TYPE i,
  lv_size_after      TYPE i,
  lv_relations_count TYPE i,
  lv_casses_count    TYPE i.

SELECT-OPTIONS so_clint FOR lv_clint.
PARAMETERS p_info TYPE abap_bool DEFAULT abap_true.

IF p_info = abap_true.
  GET RUN TIME FIELD lv_start_time.
  SELECT COUNT(*) FROM ngc_clhier_idx INTO lv_size_before. "#EC CI_NOWHERE.
  SELECT COUNT(*) FROM kssk
    INTO lv_relations_count
    WHERE
      ( objek IN so_clint OR
        clint IN so_clint ) AND
      mafid = 'K' AND
      lkenz = ' '.
  SELECT COUNT(*) FROM klah
    INTO lv_casses_count
    WHERE
      clint IN so_clint.

  WRITE: text-001, lv_size_before.
  WRITE: / text-005, lv_relations_count.
  WRITE: / text-006, lv_casses_count.
ENDIF.

CALL FUNCTION 'NGC_CORE_CLS_HIER_GENERATE' IN UPDATE TASK
  TABLES
    lt_clint = so_clint.

COMMIT WORK AND WAIT.

IF sy-subrc <> 0.
  WRITE: /, / text-007, /.
ENDIF.

IF p_info = abap_true.
  GET RUN TIME FIELD lv_end_time.
  SELECT COUNT(*) FROM ngc_clhier_idx INTO lv_size_after. "#EC CI_NOWHERE.

  lv_duration = ( lv_start_time - lv_end_time ) / 1000.

  WRITE: / text-002, lv_size_after.
  WRITE: / text-003, lv_duration, text-004.
ENDIF.