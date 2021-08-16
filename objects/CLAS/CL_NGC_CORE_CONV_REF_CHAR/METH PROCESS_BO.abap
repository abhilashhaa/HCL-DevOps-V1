METHOD process_bo.

  DATA:
    lt_attabs            TYPE ltt_attabs,
    ls_ausp              TYPE ausp,
    lv_value_exists      TYPE abap_bool.

  FIELD-SYMBOLS:
    <ls_attab>           TYPE lts_refbou,
    <ls_ausp_prev>       TYPE ausp,
    <ls_ausp_prev_chain> TYPE ausp.

  ASSIGN it_attabs[ 1 ]-obtab TO FIELD-SYMBOL(<lv_obtab>).
  ASSIGN it_attabs[ 1 ]-objek TO FIELD-SYMBOL(<lv_objek>).

  mo_refval_reader->read_ref_values(
    EXPORTING
      iv_obtab       = <lv_obtab>
      iv_objek       = <lv_objek>
    IMPORTING
      et_attabs      = lt_attabs
      ev_should_exit = DATA(lv_should_exit)
    CHANGING
      ct_refvals     = ct_refvals
      ct_events      = ct_events
  ).
  IF lv_should_exit = abap_true.
    RETURN.
  ENDIF.

  " Now let's see the requested attabs.
  LOOP AT it_attabs ASSIGNING <ls_attab>.
    READ TABLE lt_attabs TRANSPORTING NO FIELDS WITH KEY table_line = <ls_attab>-attab.
    CHECK sy-subrc EQ 0. " Skip the unavailable attabs
    IF <ls_attab>-kssklkenz EQ 'X' AND <ls_ausp_prev_chain> IS ASSIGNED.
      " All of this is needed because we want the AENNR in the case of class unassignments as well:
      DATA(lv_ls_attab_ksskdatuv_m1) = <ls_attab>-ksskdatuv - 1.
      IF <ls_ausp_prev_chain>-atinn EQ <ls_attab>-atinn
      AND <ls_ausp_prev_chain>-klart EQ <ls_attab>-klart
      AND <ls_ausp_prev_chain>-datub EQ lv_ls_attab_ksskdatuv_m1.
          APPEND <ls_ausp_prev_chain> TO ct_ausp_modify ASSIGNING <ls_ausp_prev>.
          <ls_ausp_prev>-lkenz = 'X'.
          <ls_ausp_prev>-datuv = <ls_attab>-ksskdatuv.
          <ls_ausp_prev>-aennr = <ls_attab>-ksskaennr.
          <ls_ausp_prev>-datub = <ls_attab>-ksskdatub.
          ASSIGN <ls_ausp_prev> TO <ls_ausp_prev_chain>.
          UNASSIGN <ls_ausp_prev>.
      ELSE.
        UNASSIGN <ls_ausp_prev_chain>.
      ENDIF.
    ELSE.
      UNASSIGN <ls_ausp_prev_chain>.

      " Let's check if this class type supports change numbers at all:
      IF me->get_clstype_ech( iv_klart = <ls_attab>-klart  iv_obtab = <ls_attab>-obtab ) NE abap_false.
        " Handle only the relevant validities:
        LOOP AT ct_refvals ASSIGNING FIELD-SYMBOL(<ls_refval>) WHERE datuv GE <ls_attab>-ksskdatuv AND datuv LE <ls_attab>-ksskdatub.
          mo_refval_reader->refval_to_ausp(
            EXPORTING
              is_refval       = <ls_refval>
              is_attab        = <ls_attab>
            IMPORTING
              es_ausp         = ls_ausp
              ev_value_exists = lv_value_exists
            CHANGING
              ct_events       = ct_events
          ).
          IF lv_value_exists EQ abap_true.
            IF <ls_ausp_prev> IS ASSIGNED.
              " Set the datub for the previous line:
              <ls_ausp_prev>-datub = ls_ausp-datuv - 1.
            ENDIF.
            APPEND ls_ausp TO ct_ausp_modify ASSIGNING <ls_ausp_prev>.
          ELSE.
            " So we do NOT have a value with this datuv.
            IF <ls_ausp_prev> IS ASSIGNED.
              " Create lkenz='X' lines only after we had at least one value before.
              ls_ausp = <ls_ausp_prev>.
              ls_ausp-lkenz = abap_true.
              ls_ausp-datuv = <ls_refval>-datuv.
              ls_ausp-aennr = <ls_refval>-aennr.
              " Set the datub for the previous line:
              <ls_ausp_prev>-datub = ls_ausp-datuv - 1.
              APPEND ls_ausp TO ct_ausp_modify ASSIGNING <ls_ausp_prev>.
            ENDIF.
          ENDIF.
        ENDLOOP.
        IF <ls_ausp_prev> IS ASSIGNED.
          " Set the last datub.
          <ls_ausp_prev>-datub = <ls_attab>-ksskdatub.
          ASSIGN <ls_ausp_prev> TO <ls_ausp_prev_chain>.
          UNASSIGN <ls_ausp_prev>.
        ENDIF.
      ELSE.
        " So this class type does not support change numbers.
        " But the BO type might support it, so we have to get the 'last' ref. value to write a single AUSP entry.
        lv_value_exists = abap_false.
        DESCRIBE TABLE ct_refvals LINES DATA(lv_refvals_num).
        WHILE lv_refvals_num GT 0 AND lv_value_exists EQ abap_false.
          READ TABLE ct_refvals ASSIGNING <ls_refval> INDEX lv_refvals_num.
          mo_refval_reader->refval_to_ausp(
            EXPORTING
              is_refval       = <ls_refval>
              is_attab        = <ls_attab>
            IMPORTING
              es_ausp         = ls_ausp
              ev_value_exists = lv_value_exists
            CHANGING
              ct_events       = ct_events
          ).
          SUBTRACT 1 FROM lv_refvals_num.
        ENDWHILE.
        IF lv_value_exists EQ abap_true.
          " So we have a value: write a single ausp entry for this.
          ls_ausp-datuv = gc_min_date.
          ls_ausp-datub = gc_max_date.
          ls_ausp-aennr = ''.
          APPEND ls_ausp TO ct_ausp_modify.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDMETHOD.