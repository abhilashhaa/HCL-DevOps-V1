  METHOD name.

    DATA: lv_path TYPE string.

    TRY.
        regex( EXPORTING iv_url = iv_url
               IMPORTING ev_name = rv_name
                         ev_path = lv_path ).

        IF rv_name IS INITIAL.
          FIND REGEX '([\w-]+)/$' IN lv_path SUBMATCHES rv_name.
          IF sy-subrc <> 0.
            zcx_abapgit_exception=>raise( 'Malformed URL' ).
          ENDIF.
        ENDIF.

      CATCH zcx_abapgit_exception.
        IF iv_validate = abap_true.
          zcx_abapgit_exception=>raise( 'Malformed URL' ).
        ELSE.
          rv_name = 'URL error (fix repo with "Advanced > Change Remote")'.
        ENDIF.
    ENDTRY.

  ENDMETHOD.