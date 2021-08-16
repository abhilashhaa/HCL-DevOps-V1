  METHOD zif_abapgit_object~changed_by.

    DATA: lv_dsonam  TYPE c LENGTH 30,
          ls_return  TYPE bapiret2,
          lr_details TYPE REF TO data.

    FIELD-SYMBOLS: <lg_details> TYPE any,
                   <lg_tstpnm>  TYPE any.

    TRY.
        CREATE DATA lr_details TYPE ('BAPI6116').
      CATCH cx_sy_create_data_error.
        zcx_abapgit_exception=>raise( |ODSO is not supported on this system| ).
    ENDTRY.

    ASSIGN lr_details->* TO <lg_details>.

    lv_dsonam = ms_item-obj_name.

    CALL FUNCTION 'BAPI_ODSO_GETDETAIL'
      EXPORTING
        odsobject = lv_dsonam
      IMPORTING
        details   = <lg_details>
        return    = ls_return.

    IF ls_return-type = 'E'.
      zcx_abapgit_exception=>raise( |Error when geting changed by of ODSO: { ls_return-message }| ).
    ENDIF.

    ASSIGN COMPONENT 'TSTPNM' OF STRUCTURE <lg_details> TO <lg_tstpnm>.

    rv_user = <lg_tstpnm>.

  ENDMETHOD.