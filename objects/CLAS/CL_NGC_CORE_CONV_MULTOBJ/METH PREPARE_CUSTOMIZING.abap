METHOD prepare_customizing.
  DATA:
    lt_tclt      TYPE HASHED   TABLE OF tclt  WITH UNIQUE KEY obtab,
    lt_tcltt     TYPE SORTED   TABLE OF tcltt WITH UNIQUE KEY obtab spras,
    lt_tclao_dup TYPE STANDARD TABLE OF tclao,
    lt_tclax_dup TYPE STANDARD TABLE OF tclax,
    lv_errtabs   TYPE string.

  MESSAGE i033(upgba) WITH 'Preparing Customizing data.' INTO cl_upgba_logger=>mv_logmsg.
  cl_upgba_logger=>log->trace_single( ).

  CLEAR: mt_tclao, mt_tclax.

  SELECT * FROM tclt INTO TABLE lt_tclt. "#EC CI_GENBUFF.
  SELECT * FROM tcltt INTO TABLE lt_tcltt. "#EC CI_GENBUFF.

  " Handle all class types where MULTOBJ is not enabled yet
  " klart exclusions: it should already be excluded, but just in case...
  LOOP AT mt_tcla ASSIGNING FIELD-SYMBOL(<ms_tcla>) WHERE multobj = ' ' AND klart <> '230' AND klart <> '102'.
    READ TABLE lt_tclt WITH TABLE KEY obtab = <ms_tcla>-obtab ASSIGNING FIELD-SYMBOL(<ls_tclt>).

    " Make the TCLAO entry
    APPEND INITIAL LINE TO mt_tclao ASSIGNING FIELD-SYMBOL(<ms_tclao>).
    MOVE-CORRESPONDING <ls_tclt> TO <ms_tclao>.
    <ms_tclao>-mandt      = sy-mandt.
    <ms_tclao>-klart      = <ms_tcla>-klart.
    <ms_tclao>-mfkls      = <ms_tcla>-mfkls.
    <ms_tclao>-tracl      = <ms_tcla>-tracl.
    <ms_tclao>-aeblgzuord = <ms_tcla>-aeblgzuord.
    <ms_tclao>-aediezuord = <ms_tcla>-aediezuord.

    " Make TCLAX entries
    LOOP AT lt_tcltt ASSIGNING FIELD-SYMBOL(<ls_tcltt>) WHERE obtab = <ms_tcla>-obtab.
      APPEND INITIAL LINE TO mt_tclax ASSIGNING FIELD-SYMBOL(<ms_tclax>).
      MOVE-CORRESPONDING <ls_tcltt> TO <ms_tclax>.
      <ms_tclax>-mandt     = sy-mandt.
      <ms_tclax>-klart     = <ms_tcla>-klart.
      <ms_tclax>-drucktext = <ls_tcltt>-obtxt.
      <ms_tclax>-objtype   = <ls_tcltt>-obtxt.
    ENDLOOP.
  ENDLOOP.

  IF lines( mt_tclao ) <> 0.
    SELECT * FROM tclao
      FOR ALL ENTRIES IN @mt_tclao
      WHERE klart = @mt_tclao-klart AND obtab = @mt_tclao-obtab
      INTO TABLE @lt_tclao_dup.
  ENDIF.
  IF lines( mt_tclax ) <> 0.
    SELECT * FROM tclax
      FOR ALL ENTRIES IN @mt_tclax
      WHERE spras = @mt_tclax-spras AND klart = @mt_tclax-klart AND obtab = @mt_tclax-obtab
      INTO TABLE @lt_tclax_dup.
  ENDIF.

  LOOP AT lt_tclao_dup ASSIGNING FIELD-SYMBOL(<ls_tclao_dup>).
    MESSAGE w035(upgba) WITH 'TCLAO entry already exist: klart = ' <ls_tclao_dup>-klart 'obtab = ' <ls_tclao_dup>-obtab INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).
  ENDLOOP.
  LOOP AT lt_tclax_dup ASSIGNING FIELD-SYMBOL(<ls_tclax_dup>).
    MESSAGE w035(upgba) WITH `TCLAX entry already exist: spras = ` && <ls_tclax_dup>-spras `klart = ` && <ls_tclax_dup>-klart `obtab = ` && <ls_tclax_dup>-obtab INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).
  ENDLOOP.

  lv_errtabs = ''.
  IF lines( lt_tclao_dup ) <> 0 AND lines( lt_tclax_dup ) <> 0.
    lv_errtabs = 'TCLAO and TCLAX'.
  ELSEIF lines( lt_tclao_dup ) <> 0.
    lv_errtabs = 'TCLAO'.
  ELSEIF lines( lt_tclax_dup ) <> 0.
    lv_errtabs = 'TCLAX'.
  ENDIF.
  IF lv_errtabs NE ''.
    CASE mv_customizing_handling.
      WHEN 1.
        MESSAGE w034(upgba) WITH 'Duplicate entries in' lv_errtabs 'will be overwritten with the new ones!' INTO cl_upgba_logger=>mv_logmsg.
        cl_upgba_logger=>log->trace_single( ).
      WHEN 2.
        LOOP AT lt_tclao_dup ASSIGNING <ls_tclao_dup>.
          DELETE mt_tclao WHERE klart = <ls_tclao_dup>-klart AND obtab = <ls_tclao_dup>-obtab.
        ENDLOOP.
        LOOP AT lt_tclax_dup ASSIGNING <ls_tclax_dup>.
          DELETE mt_tclax WHERE spras = <ls_tclax_dup>-spras AND klart = <ls_tclax_dup>-klart AND obtab = <ls_tclax_dup>-obtab.
        ENDLOOP.
        MESSAGE w034(upgba) WITH 'Duplicate entries in' lv_errtabs 'will be kept without overwriting!' INTO cl_upgba_logger=>mv_logmsg.
        cl_upgba_logger=>log->trace_single( ).
      WHEN OTHERS. " when 0 included
        CALL FUNCTION 'DB_ROLLBACK'.
        RAISE EXCEPTION TYPE cx_data_conv_error
          MESSAGE ID 'UPGBA'
          TYPE 'E'
          NUMBER '035'
          WITH 'DB Inconsistency!' 'There are one or more entries in' lv_errtabs 'with TCLA.MULTOBJ=false!'.
    ENDCASE.
  ENDIF.

  MESSAGE i033(upgba) WITH 'Preparing Customizing data finished.' INTO cl_upgba_logger=>mv_logmsg.
  cl_upgba_logger=>log->trace_single( ).
ENDMETHOD.