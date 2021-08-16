  METHOD list.

    DATA: lt_list TYPE zif_abapgit_persistence=>tt_content,
          ls_xml  TYPE ty_xml.

    FIELD-SYMBOLS: <ls_list>   LIKE LINE OF lt_list,
                   <ls_output> LIKE LINE OF rt_list.

    IF lines( mt_jobs ) > 0.
      rt_list = mt_jobs.
      RETURN.
    ENDIF.


    lt_list = mo_db->list_by_type( zcl_abapgit_persistence_db=>c_type_background ).

    LOOP AT lt_list ASSIGNING <ls_list>.
      ls_xml = from_xml( <ls_list>-data_str ).

      APPEND INITIAL LINE TO rt_list ASSIGNING <ls_output>.
      MOVE-CORRESPONDING ls_xml TO <ls_output>.
      <ls_output>-key = <ls_list>-value.
    ENDLOOP.

    mt_jobs = rt_list.

  ENDMETHOD.