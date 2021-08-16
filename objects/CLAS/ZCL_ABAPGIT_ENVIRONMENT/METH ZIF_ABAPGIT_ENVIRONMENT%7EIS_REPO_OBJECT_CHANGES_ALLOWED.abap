  METHOD zif_abapgit_environment~is_repo_object_changes_allowed.
    DATA lv_ind TYPE t000-ccnocliind.

    IF mv_client_modifiable = abap_undefined.
      SELECT SINGLE ccnocliind FROM t000 INTO lv_ind
             WHERE mandt = sy-mandt.
      IF sy-subrc = 0
          AND ( lv_ind = ' ' OR lv_ind = '1' ). "check changes allowed
        mv_client_modifiable = abap_true.
      ELSE.
        mv_client_modifiable = abap_false.
      ENDIF.
    ENDIF.
    rv_result = mv_client_modifiable.
  ENDMETHOD.