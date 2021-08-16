  METHOD update_extra.
    DATA: lt_current_tvimf TYPE STANDARD TABLE OF tvimf.
    FIELD-SYMBOLS: <ls_tvimf> TYPE tvimf.

    MODIFY tddat FROM is_tobj-tddat.
    MODIFY tvdir FROM is_tobj-tvdir.

    SELECT * INTO TABLE lt_current_tvimf
      FROM tvimf
      WHERE tabname = is_tobj-tddat-tabname
      ORDER BY PRIMARY KEY.

    LOOP AT lt_current_tvimf ASSIGNING <ls_tvimf>.
      READ TABLE is_tobj-tvimf WITH KEY tabname = <ls_tvimf>-tabname
                                        event   = <ls_tvimf>-event
                               TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        DELETE FROM tvimf
          WHERE tabname = <ls_tvimf>-tabname
          AND event = <ls_tvimf>-event.
      ENDIF.
    ENDLOOP.

    MODIFY tvimf FROM TABLE is_tobj-tvimf.
  ENDMETHOD.