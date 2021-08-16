  METHOD serialize_model.

    DATA ls_dm40l TYPE dm40l.

    " See SDU_MODEL_GET.
    SELECT SINGLE *
    FROM dm40l
    INTO ls_dm40l
    WHERE dmoid    = me->mv_data_model
    AND   as4local = me->mv_activation_state.


    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from UDMO - model serialisation' ).
    ENDIF.

    " You are reminded that administrative data is not serialised.
    CLEAR ls_dm40l-lstdate.
    CLEAR ls_dm40l-lsttime.
    CLEAR ls_dm40l-lstuser.
    CLEAR ls_dm40l-fstdate.
    CLEAR ls_dm40l-fsttime.
    CLEAR ls_dm40l-fstuser.

    io_xml->add( iv_name = 'DM40L'
                 ig_data = ls_dm40l ).

  ENDMETHOD.