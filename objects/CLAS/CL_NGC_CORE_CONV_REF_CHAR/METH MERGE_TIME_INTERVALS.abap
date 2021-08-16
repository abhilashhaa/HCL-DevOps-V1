METHOD merge_time_intervals.

  FIELD-SYMBOLS:
    <ls_ausp_prev>  TYPE ausp,
    <ls_ausp_lkenz> TYPE ausp.

  LOOP AT ct_ausp ASSIGNING FIELD-SYMBOL(<ls_ausp>).
    IF <ls_ausp_prev> IS ASSIGNED.
      " First check if we are in the same objek-atinn-atzhl-mafid-klart chain:
      IF <ls_ausp_prev>-objek EQ <ls_ausp>-objek
      AND <ls_ausp_prev>-atinn EQ <ls_ausp>-atinn
      AND <ls_ausp_prev>-atzhl EQ <ls_ausp>-atzhl
      AND <ls_ausp_prev>-mafid EQ <ls_ausp>-mafid
      AND <ls_ausp_prev>-klart EQ <ls_ausp>-klart.
        DATA(lv_ls_ausp_datuv_minus_1) = <ls_ausp>-datuv - 1.

        " Now check if we have a gap in validites or if we can merge lines:
        IF <ls_ausp_prev>-datub LT lv_ls_ausp_datuv_minus_1.
          " Ok, fill the gap with a line with LKENZ='X'.
          " Ideally, this case should not happen because we now use LKENZ=X from KSSK as well, so this is just a failsafe.
          INSERT <ls_ausp_prev> INTO ct_ausp ASSIGNING <ls_ausp_lkenz>.
          <ls_ausp_lkenz>-aennr = ''.
          <ls_ausp_lkenz>-datuv = <ls_ausp_prev>-datub + 1.
          <ls_ausp_lkenz>-datub = lv_ls_ausp_datuv_minus_1.
          <ls_ausp_lkenz>-lkenz = 'X'.
          ADD 1 TO <ls_ausp_lkenz>-adzhl.
          <ls_ausp>-adzhl = <ls_ausp_lkenz>-adzhl + 1.
        ELSEIF <ls_ausp_prev>-datuv EQ <ls_ausp>-datuv.
          " So we have the same again, probably because two alternative references had values at the same time.
          " Delete the current line, as we do not need duplicates:
          DELETE ct_ausp.
          " Go to the next line without updating <ls_ausp_prev>:
          CONTINUE.
        ELSEIF <ls_ausp_prev>-lkenz EQ <ls_ausp>-lkenz
        AND <ls_ausp_prev>-atwrt EQ <ls_ausp>-atwrt
        AND <ls_ausp_prev>-atflv EQ <ls_ausp>-atflv
        AND <ls_ausp_prev>-atawe EQ <ls_ausp>-atawe
        AND <ls_ausp_prev>-atflb EQ <ls_ausp>-atflb
        AND <ls_ausp_prev>-ataw1 EQ <ls_ausp>-ataw1
        AND <ls_ausp_prev>-atcod EQ <ls_ausp>-atcod
        AND <ls_ausp_prev>-attlv EQ <ls_ausp>-attlv
        AND <ls_ausp_prev>-attlb EQ <ls_ausp>-attlb
        AND <ls_ausp_prev>-atprz EQ <ls_ausp>-atprz
        AND <ls_ausp_prev>-atinc EQ <ls_ausp>-atinc
        AND <ls_ausp_prev>-ataut EQ <ls_ausp>-ataut
        AND <ls_ausp_prev>-datub EQ lv_ls_ausp_datuv_minus_1.
          " Ok, so we can merge the current line with the previous.
          <ls_ausp_prev>-datub = <ls_ausp>-datub.
          " Delete the current line, its joined to the previous:
          DELETE ct_ausp.
          " Go to the next line without updating <ls_ausp_prev>:
          CONTINUE.
        ELSE.
          " We can NOT merge the current line with the previous.
          " So update the ADZHL.
          <ls_ausp>-adzhl = <ls_ausp_prev>-adzhl + 1.
        ENDIF.
      ELSE.
        " So we are in a different objek-atinn-atzhl-mafid-klart chain.
        " Let's check the end of the previous chain:
        IF <ls_ausp_prev>-datub NE gc_max_date.
          " So we have an uncovered interval until 9999.12.31.
          " Ideally, this case should not happen because we now use LKENZ=X from KSSK as well, so this is just a failsafe.
          IF <ls_ausp_prev>-lkenz EQ 'X'.
            " Ok, we just have to extend the last entry.
            <ls_ausp_prev>-datub = gc_max_date.
          ELSE.
            " We have to make a new entry with lkenz = 'X'.
            INSERT <ls_ausp_prev> INTO ct_ausp ASSIGNING <ls_ausp_lkenz>.
            <ls_ausp_lkenz>-aennr = ''.
            <ls_ausp_lkenz>-datuv = <ls_ausp_prev>-datub + 1.
            <ls_ausp_lkenz>-datub = gc_max_date.
            <ls_ausp_lkenz>-lkenz = 'X'.
            ADD 1 TO <ls_ausp_lkenz>-adzhl.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
    ASSIGN <ls_ausp> TO <ls_ausp_prev>.
  ENDLOOP.
  IF <ls_ausp_prev> IS ASSIGNED.
    " Let's check the end of the last chain:
    IF <ls_ausp_prev>-datub NE gc_max_date.
      " So we have an uncovered interval until 9999.12.31.
      " Ideally, this case should not happen because we now use LKENZ=X from KSSK as well, so this is just a failsafe.
      IF <ls_ausp_prev>-lkenz EQ 'X'.
        " Ok, we just have to extend the last entry.
        <ls_ausp_prev>-datub = gc_max_date.
      ELSE.
        " We have to make a new entry with lkenz = 'X'.
        APPEND <ls_ausp_prev> TO ct_ausp ASSIGNING <ls_ausp_lkenz>.
        <ls_ausp_lkenz>-aennr = ''.
        <ls_ausp_lkenz>-datuv = <ls_ausp_prev>-datub + 1.
        <ls_ausp_lkenz>-datub = gc_max_date.
        <ls_ausp_lkenz>-lkenz = 'X'.
        ADD 1 TO <ls_ausp_lkenz>-adzhl.
      ENDIF.
    ENDIF.
  ENDIF.

ENDMETHOD.