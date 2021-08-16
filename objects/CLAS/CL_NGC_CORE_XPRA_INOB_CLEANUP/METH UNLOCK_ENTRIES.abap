METHOD unlock_entries.

  " unlock locked entries of KSSK
  LOOP AT mt_locked_inob ASSIGNING FIELD-SYMBOL(<ls_inob>).
    TEST-SEAM unlock_seam.
      CALL FUNCTION 'DEQUEUE_ECKSSKXE'
        EXPORTING
          mode_ksskx = 'E'
          mandt      = <ls_inob>-mandt
          klart      = <ls_inob>-klart
          mafid      = 'O'
          objek      = <ls_inob>-objek.
    END-TEST-SEAM.
  ENDLOOP.
  CLEAR: mt_locked_inob.

ENDMETHOD.