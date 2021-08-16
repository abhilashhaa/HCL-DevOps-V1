  METHOD get_vo_flags_from_dom.

    " downport from CL_APL_ECATT_VO_UPLOAD

    DATA: li_section            TYPE REF TO if_ixml_element,
          lv_error_prio         TYPE zif_abapgit_ecatt=>etvo_error_prio,
          lv_invert_validation  TYPE zif_abapgit_ecatt=>etvo_invert_validation,
          lv_exception_occurred TYPE etonoff,
          lo_ecatt_vo           TYPE REF TO object.

    FIELD-SYMBOLS: <lg_ecatt_vo> TYPE any.

    li_section = template_over_all->find_from_name_ns( 'INVERT_VALIDATION' ).

    IF NOT li_section IS INITIAL.
      CALL FUNCTION 'SDIXML_DOM_TO_DATA'
        EXPORTING
          data_as_dom    = li_section
        IMPORTING
          dataobject     = lv_invert_validation
        EXCEPTIONS
          illegal_object = 1
          OTHERS         = 2.
      IF sy-subrc <> 0.
        CLEAR lv_invert_validation.
      ENDIF.
    ENDIF.

    ASSIGN ('ECATT_OBJECT') TO <lg_ecatt_vo>.
    ASSERT sy-subrc = 0.

    lo_ecatt_vo = <lg_ecatt_vo>.

    TRY.
        CALL METHOD lo_ecatt_vo->('SET_INVERT_VALIDATION_FLAG')
          EXPORTING
            im_invert_validation = lv_invert_validation.

      CATCH cx_ecatt_apl INTO exception_to_raise.
        lv_exception_occurred = 'X'.
    ENDTRY.

    li_section = template_over_all->find_from_name_ns( 'ERROR_PRIORITY' ).

    IF NOT li_section IS INITIAL.
      CALL FUNCTION 'SDIXML_DOM_TO_DATA'
        EXPORTING
          data_as_dom    = li_section
        IMPORTING
          dataobject     = lv_error_prio
        EXCEPTIONS
          illegal_object = 1
          OTHERS         = 2.
      IF sy-subrc <> 0.
        CLEAR lv_invert_validation.
      ENDIF.
    ENDIF.

    TRY.
        CALL METHOD lo_ecatt_vo->('SET_ERROR_PRIORITY')
          EXPORTING
            im_error_prio = lv_error_prio.
      CATCH cx_ecatt_apl INTO exception_to_raise.
        lv_exception_occurred = 'X'.
    ENDTRY.

    IF lv_exception_occurred = 'X'.
      raise_upload_exception( previous = exception_to_raise ).
    ENDIF.

  ENDMETHOD.