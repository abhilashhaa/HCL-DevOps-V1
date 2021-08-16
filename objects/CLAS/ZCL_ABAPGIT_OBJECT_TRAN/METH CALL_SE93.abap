  METHOD call_se93.

    DATA: lt_message TYPE STANDARD TABLE OF bdcmsgcoll.

    FIELD-SYMBOLS: <ls_message> TYPE bdcmsgcoll.


    CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
      EXPORTING
        tcode     = 'SE93'
        mode_val  = 'N'
      TABLES
        using_tab = mt_bcdata
        mess_tab  = lt_message
      EXCEPTIONS
        OTHERS    = 1.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error deserializing { ms_item-obj_type } { ms_item-obj_name }| ).
    ENDIF.

    LOOP AT lt_message ASSIGNING <ls_message> WHERE msgtyp CA 'EAX'.
      MESSAGE ID <ls_message>-msgid
        TYPE <ls_message>-msgtyp
        NUMBER <ls_message>-msgnr
        WITH <ls_message>-msgv1 <ls_message>-msgv2 <ls_message>-msgv3 <ls_message>-msgv4
        INTO sy-msgli.
      zcx_abapgit_exception=>raise_t100( ).
    ENDLOOP.

  ENDMETHOD.