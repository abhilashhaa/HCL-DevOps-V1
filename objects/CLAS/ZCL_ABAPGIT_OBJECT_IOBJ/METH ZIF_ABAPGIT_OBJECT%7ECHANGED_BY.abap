  METHOD zif_abapgit_object~changed_by.

    DATA: lv_objna TYPE c LENGTH 30,
          lr_viobj TYPE REF TO data.

    FIELD-SYMBOLS:
      <lg_tstpnm> TYPE any,
      <lg_viobj>  TYPE any.

    lv_objna = ms_item-obj_name.

    TRY.
        CREATE DATA lr_viobj TYPE ('RSD_S_VIOBJ').
      CATCH cx_sy_create_data_error.
        zcx_abapgit_exception=>raise( |IOBJ is not supported on this system| ).
    ENDTRY.

    ASSIGN lr_viobj->* TO <lg_viobj>.

    CALL FUNCTION 'RSD_IOBJ_GET'
      EXPORTING
        i_iobjnm  = lv_objna
        i_objvers = 'A'
      IMPORTING
        e_s_viobj = <lg_viobj>.

    ASSIGN COMPONENT 'TSTPNM' OF STRUCTURE <lg_viobj> TO <lg_tstpnm>.

    rv_user = <lg_tstpnm>.

  ENDMETHOD.