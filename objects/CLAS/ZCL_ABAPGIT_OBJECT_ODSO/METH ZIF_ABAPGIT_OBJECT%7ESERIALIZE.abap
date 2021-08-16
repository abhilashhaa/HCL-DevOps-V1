  METHOD zif_abapgit_object~serialize.

    DATA: lv_dsonam      TYPE c LENGTH 30,
          lr_details     TYPE REF TO data,
          lr_infoobjects TYPE REF TO data,
          lr_navigation  TYPE REF TO data,
          lr_indexes     TYPE REF TO data,
          lr_index_iobj  TYPE REF TO data,
          ls_return      TYPE bapiret2.

    FIELD-SYMBOLS:
      <lg_details>     TYPE any,
      <lt_infoobjects> TYPE STANDARD TABLE,
      <lt_navigation>  TYPE STANDARD TABLE,
      <lt_indexes>     TYPE STANDARD TABLE,
      <lt_index_iobj>  TYPE STANDARD TABLE.

    TRY.
        CREATE DATA lr_details     TYPE ('BAPI6116').
        CREATE DATA lr_infoobjects TYPE STANDARD TABLE OF ('BAPI6116IO').
        CREATE DATA lr_navigation  TYPE STANDARD TABLE OF ('BAPI6116NA').
        CREATE DATA lr_indexes     TYPE STANDARD TABLE OF ('BAPI6116IN').
        CREATE DATA lr_index_iobj  TYPE STANDARD TABLE OF ('BAPI6116II').
      CATCH cx_sy_create_data_error.
        zcx_abapgit_exception=>raise( |ODSO is not supported on this system| ).
    ENDTRY.

    ASSIGN lr_details->*     TO <lg_details>.
    ASSIGN lr_infoobjects->* TO <lt_infoobjects>.
    ASSIGN lr_navigation->*  TO <lt_navigation>.
    ASSIGN lr_indexes->*     TO <lt_indexes>.
    ASSIGN lr_index_iobj->*  TO <lt_index_iobj>.

    lv_dsonam = ms_item-obj_name.

    CALL FUNCTION 'BAPI_ODSO_GETDETAIL'
      EXPORTING
        odsobject            = lv_dsonam
      IMPORTING
        details              = <lg_details>
        return               = ls_return
      TABLES
        infoobjects          = <lt_infoobjects>
        navigationattributes = <lt_navigation>
        indexes              = <lt_indexes>
        indexesinfoobjects   = <lt_index_iobj>.

    IF ls_return-type = 'E'.
      zcx_abapgit_exception=>raise( |Error when geting details of ODSO: { ls_return-message }| ).
    ENDIF.

    clear_field( EXPORTING iv_fieldname = 'TSTPNM'
                 CHANGING  cg_metadata  = <lg_details> ).

    clear_field( EXPORTING iv_fieldname = 'TIMESTMP'
                 CHANGING  cg_metadata  = <lg_details> ).

    clear_field( EXPORTING iv_fieldname = 'CONTTIMESTMP'
                 CHANGING  cg_metadata  = <lg_details> ).

    clear_field( EXPORTING iv_fieldname = 'OWNER'
                 CHANGING  cg_metadata  = <lg_details> ).

    io_xml->add( iv_name = 'ODSO'
                 ig_data = <lg_details> ).

    io_xml->add( iv_name = 'INFOOBJECTS'
                 ig_data = <lt_infoobjects> ).

    io_xml->add( iv_name = 'NAVIGATION'
                 ig_data = <lt_navigation> ).

    io_xml->add( iv_name = 'INDEXES'
                 ig_data = <lt_indexes> ).

    io_xml->add( iv_name = 'INDEX_IOBJ'
                 ig_data = <lt_index_iobj> ).

  ENDMETHOD.