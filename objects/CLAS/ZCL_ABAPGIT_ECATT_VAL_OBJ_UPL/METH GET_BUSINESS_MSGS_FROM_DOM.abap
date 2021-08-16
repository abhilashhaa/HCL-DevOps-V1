  METHOD get_business_msgs_from_dom.

    " downport from CL_APL_ECATT_VO_UPLOAD

    DATA: li_section            TYPE REF TO if_ixml_element,
          lt_buss_msg_ref       TYPE zif_abapgit_ecatt=>etvo_bus_msg_tabtype,
          lv_exception_occurred TYPE etonoff,
          lo_ecatt_vo           TYPE REF TO object.

    FIELD-SYMBOLS: <lg_ecatt_vo> TYPE any.

    li_section = template_over_all->find_from_name_ns( 'ETVO_MSG' ).

    IF NOT li_section IS INITIAL.
      CALL FUNCTION 'SDIXML_DOM_TO_DATA'
        EXPORTING
          data_as_dom    = li_section
        IMPORTING
          dataobject     = lt_buss_msg_ref
        EXCEPTIONS
          illegal_object = 1
          OTHERS         = 2.
      IF sy-subrc <> 0.
        CLEAR lt_buss_msg_ref.
      ENDIF.
    ENDIF.

    ASSIGN ('ECATT_OBJECT') TO <lg_ecatt_vo>.
    ASSERT sy-subrc = 0.

    lo_ecatt_vo = <lg_ecatt_vo>.

    TRY.
        CALL METHOD lo_ecatt_vo->('SET_BUSSINESS_MSG')
          EXPORTING
            im_buss_msg_ref = lt_buss_msg_ref.
      CATCH cx_ecatt_apl INTO exception_to_raise.
        lv_exception_occurred = 'X'.
    ENDTRY.

    IF lv_exception_occurred = 'X'.
      raise_upload_exception( previous = exception_to_raise ).
    ENDIF.

  ENDMETHOD.