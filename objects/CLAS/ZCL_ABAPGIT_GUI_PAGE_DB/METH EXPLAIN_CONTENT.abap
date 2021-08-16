  METHOD explain_content.

    DATA: ls_result TYPE match_result,
          ls_match  TYPE submatch_result,
          lv_cnt    TYPE i.


    CASE is_data-type.
      WHEN 'REPO'.
        FIND FIRST OCCURRENCE OF REGEX '<url>(.*)</url>'
          IN is_data-data_str IGNORING CASE RESULTS ls_result.
        READ TABLE ls_result-submatches INTO ls_match INDEX 1.
        IF sy-subrc IS INITIAL.
          rv_text = is_data-data_str+ls_match-offset(ls_match-length).
        ENDIF.

        FIND FIRST OCCURRENCE OF REGEX '<OFFLINE/>'
          IN is_data-data_str IGNORING CASE MATCH COUNT lv_cnt.
        IF lv_cnt > 0.
          rv_text = |<strong>On-line</strong>, Name: <strong>{
                    zcl_abapgit_url=>name( rv_text ) }</strong>|.
        ELSE.
          rv_text = |Off-line, Name: <strong>{ rv_text }</strong>|.
        ENDIF.

      WHEN 'BACKGROUND'.
        FIND FIRST OCCURRENCE OF REGEX '<method>(.*)</method>'
          IN is_data-data_str IGNORING CASE RESULTS ls_result.
        READ TABLE ls_result-submatches INTO ls_match INDEX 1.
        IF sy-subrc IS NOT INITIAL.
          RETURN.
        ENDIF.
        rv_text = |Method: { is_data-data_str+ls_match-offset(ls_match-length) }, |
               && |Repository: { zcl_abapgit_repo_srv=>get_instance( )->get( is_data-value )->get_name( ) }|.

      WHEN 'USER'.
        rv_text = '-'. " No additional explanation for user
      WHEN 'SETTINGS'.
        rv_text = '-'.
      WHEN OTHERS.
        IF strlen( is_data-data_str ) >= 250.
          rv_text = is_data-data_str(250).
        ELSE.
          rv_text = is_data-data_str.
        ENDIF.
        rv_text = escape( val    = rv_text
                          format = cl_abap_format=>e_html_attr ).
        rv_text = |<pre>{ rv_text }</pre>|.
    ENDCASE.
  ENDMETHOD.