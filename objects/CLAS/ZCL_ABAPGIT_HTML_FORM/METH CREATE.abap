  METHOD create.

    DATA lv_ts TYPE timestampl.

    CREATE OBJECT ro_form.
    ro_form->mv_form_id = iv_form_id.

    IF ro_form->mv_form_id IS INITIAL.
      GET TIME STAMP FIELD lv_ts.
      ro_form->mv_form_id = |form_{ lv_ts }|.
    ENDIF.

  ENDMETHOD.