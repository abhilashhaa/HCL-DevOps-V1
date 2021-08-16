  METHOD deserialize_model.

    DATA ls_dm40l TYPE dm40l.


    io_xml->read( EXPORTING iv_name = 'DM40L'
                  CHANGING cg_data = ls_dm40l ).


    " See SDU_MODEL_PUT
    GET TIME.

    ls_dm40l-flg_frame = abap_true.
    ls_dm40l-fstdate   = sy-datum.
    ls_dm40l-fsttime   = sy-uzeit.
    ls_dm40l-fstuser   = sy-uname.
    ls_dm40l-lstdate   = sy-datum.
    ls_dm40l-lsttime   = sy-uzeit.
    ls_dm40l-lstuser   = sy-uname.

    MODIFY dm40l FROM ls_dm40l.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from SDU_MODEL_PUT' ).
    ENDIF.



  ENDMETHOD.