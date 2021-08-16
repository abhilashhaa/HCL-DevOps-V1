  METHOD compress_internal.

    FIELD-SYMBOLS: <ls_temp>     LIKE LINE OF ct_temp,
                   <ls_new>      LIKE LINE OF ct_commits,
                   <ls_temp_end> LIKE LINE OF ct_temp.


    IF lines( ct_temp ) >= 10.
      READ TABLE ct_temp ASSIGNING <ls_temp> INDEX 1.
      ASSERT sy-subrc = 0.
      READ TABLE ct_temp ASSIGNING <ls_temp_end> INDEX lines( ct_temp ).
      ASSERT sy-subrc = 0.
      APPEND INITIAL LINE TO ct_commits ASSIGNING <ls_new>.
      <ls_new>-sha1       = <ls_temp_end>-sha1.
      <ls_new>-parent1    = <ls_temp>-parent1.
      <ls_new>-time       = <ls_temp>-time.
      <ls_new>-message    = |Compressed, { lines( ct_temp ) } commits|.
      <ls_new>-branch     = iv_name.
      <ls_new>-compressed = abap_true.
    ELSE.
      APPEND LINES OF ct_temp TO ct_commits.
    ENDIF.
    CLEAR ct_temp.

  ENDMETHOD.