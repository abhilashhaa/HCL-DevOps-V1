  METHOD call_bte.

* This implementation is adapted from:
* Include: LCLFMF41
* Form: open_fi_sfa

    DATA:
      lt_allkssk_tab TYPE rmclkssk_tab,
      lt_allausp_tab TYPE rmclausp_tab,
      lt_fmrc_tab    TYPE STANDARD TABLE OF fmrfc,
      lt_delob       TYPE tt_rmcldob.

    FIELD-SYMBOLS:
      <ls_ausp> TYPE rmclausp.

    " check if this function is active
    mo_bte->bf_functions_find(
      EXPORTING
        i_event = '00004002'
      IMPORTING
        t_fmrfc = lt_fmrc_tab
    ).

    IF sy-subrc IS NOT INITIAL.
      RETURN.
    ENDIF.

    " Copy input data to local variables
    lt_allkssk_tab = it_kssk_insert_fm.
    lt_allausp_tab = it_ausp_fm.

    " merge IT_KSSK_DELETE_FM into lt_allkssk_tab
    LOOP AT it_kssk_delete_fm ASSIGNING FIELD-SYMBOL(<ls_kssk_delete_fm>).
      READ TABLE lt_allkssk_tab TRANSPORTING NO FIELDS
                 WITH KEY objek = <ls_kssk_delete_fm>-objek
                          clint = <ls_kssk_delete_fm>-clint
                          klart = <ls_kssk_delete_fm>-klart
                          mafid = <ls_kssk_delete_fm>-mafid
                          vbkz  = if_ngc_core_c=>gc_object_state-deleted.
      IF sy-subrc <> 0.
        APPEND INITIAL LINE TO lt_allkssk_tab ASSIGNING FIELD-SYMBOL(<ls_allkssk>).
        MOVE-CORRESPONDING <ls_kssk_delete_fm> TO <ls_allkssk>.
        <ls_allkssk>-vbkz = if_ngc_core_c=>gc_object_state-deleted.
      ENDIF.
    ENDLOOP.

    " Remove entries which don't contain any changes (VBKZ = ''
    LOOP AT lt_allkssk_tab ASSIGNING <ls_allkssk>
      WHERE vbkz  = space
        AND mafid = 'O'.

      " Check if there is at least one assignment for the same object with changes
      LOOP AT it_kssk_insert_fm TRANSPORTING NO FIELDS
        WHERE objek = <ls_allkssk>-objek
          AND klart = <ls_allkssk>-klart
          AND mafid = <ls_allkssk>-mafid
          AND vbkz  <> space.
        EXIT.
      ENDLOOP.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.

      LOOP AT lt_allausp_tab ASSIGNING FIELD-SYMBOL(<ls_allausp>)
                            WHERE objek = <ls_allkssk>-objek
                              AND klart = <ls_allkssk>-klart
                              AND mafid = <ls_allkssk>-mafid
                              AND statu <> space.
        EXIT.
      ENDLOOP.
      IF sy-subrc <> 0.
        LOOP AT lt_allausp_tab ASSIGNING <ls_allausp>
                              WHERE objek = <ls_allkssk>-objek
                                AND klart = <ls_allkssk>-klart
                                AND mafid = <ls_allkssk>-mafid.
          DELETE lt_allausp_tab.
        ENDLOOP.
        DELETE lt_allkssk_tab.
      ENDIF.
    ENDLOOP.

    SORT lt_allausp_tab BY objek atinn atzhl mafid klart
                          statu .        "Space, H oder L

    DELETE ADJACENT DUPLICATES FROM lt_allausp_tab COMPARING
                                    objek atinn atzhl mafid klart .

    mo_bte->open_fi_perform_00004002_e(
      i_ecm_no         = space
      i_delob_tab      = lt_delob
      i_allocation_tab = lt_allkssk_tab
      i_value_tab      = lt_allausp_tab
    ).

  ENDMETHOD.