  METHOD get_impl_detail_from_dom.

    " downport from CL_APL_ECATT_VO_UPLOAD

    DATA: li_section            TYPE REF TO if_ixml_element,
          ls_impl_details       TYPE zif_abapgit_ecatt=>etvoimpl_det,
          lv_exception_occurred TYPE etonoff,
          lo_ecatt_vo           TYPE REF TO object.

    FIELD-SYMBOLS: <lg_ecatt_vo> TYPE any.

    li_section = template_over_all->find_from_name_ns( 'IMPL_DET' ).

    IF NOT li_section IS INITIAL.
      CALL FUNCTION 'SDIXML_DOM_TO_DATA'
        EXPORTING
          data_as_dom    = li_section
        IMPORTING
          dataobject     = ls_impl_details
        EXCEPTIONS
          illegal_object = 1
          OTHERS         = 2.
      IF sy-subrc <> 0.
        CLEAR ls_impl_details.
      ENDIF.
    ENDIF.

    ASSIGN ('ECATT_OBJECT') TO <lg_ecatt_vo>.
    ASSERT sy-subrc = 0.

    lo_ecatt_vo = <lg_ecatt_vo>.

    TRY.
        CALL METHOD lo_ecatt_vo->('SET_IMPL_DETAILS')
          EXPORTING
            im_impl_details = ls_impl_details.
      CATCH cx_ecatt_apl INTO exception_to_raise.
        lv_exception_occurred = 'X'.
    ENDTRY.

    IF lv_exception_occurred = 'X'.
      raise_upload_exception( previous = exception_to_raise ).
    ENDIF.

  ENDMETHOD.