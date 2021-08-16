  METHOD if_ngc_rap_cls_bapi_util~delete_classtext_api.

    DATA:
      lt_classtext_bapi TYPE STANDARD TABLE OF klklat,
      lv_error          TYPE syst_binpt.

    LOOP AT it_classtext ASSIGNING FIELD-SYMBOL(<ls_classtext>).
      APPEND INITIAL LINE TO lt_classtext_bapi ASSIGNING FIELD-SYMBOL(<ls_classtext_bapi>).
      <ls_classtext_bapi>-spras = <ls_classtext>-langu.
      <ls_classtext_bapi>-txtid = |00{ <ls_classtext>-text_type }|.
      <ls_classtext_bapi>-txtbz = <ls_classtext>-text_descr.
    ENDLOOP.

    CALL FUNCTION 'CLCM_CLASS_TEXT_DELETE'
      EXPORTING
        classname            = iv_class
        classtype            = iv_classtype
      IMPORTING
        error                = lv_error
      TABLES
        tklat                = lt_classtext_bapi
      EXCEPTIONS
        class_invalid_change = 1.

    IF sy-subrc = 1.
      " Class text cannot be removed
      MESSAGE e048(ngc_rap) INTO DATA(lv_message) ##NEEDED.
      APPEND VALUE bapiret2( id = 'NGC_RAP' number = 048 type = 'E' ) TO rt_return.
    ENDIF.

    IF lv_error IS NOT INITIAL.
      APPEND VALUE bapiret2(
        id = sy-msgid number = sy-msgno type = sy-msgty message_v1 = sy-msgv1 message_v2 = sy-msgv2 message_v3 = sy-msgv3 message_v4 = sy-msgv4 )
        TO rt_return.
    ENDIF.

  ENDMETHOD.