  METHOD zif_abapgit_longtexts~changed_by.

    DATA: lt_longtexts TYPE tty_longtexts.
    FIELD-SYMBOLS: <ls_longtext> TYPE ty_longtext.

    lt_longtexts = read( iv_object_name = iv_object_name
                         iv_longtext_id = iv_longtext_id
                         it_dokil       = it_dokil ).

    READ TABLE lt_longtexts INDEX 1 ASSIGNING <ls_longtext>.
    IF sy-subrc = 0.
      rv_user = <ls_longtext>-head-tdluser.
    ENDIF.

  ENDMETHOD.