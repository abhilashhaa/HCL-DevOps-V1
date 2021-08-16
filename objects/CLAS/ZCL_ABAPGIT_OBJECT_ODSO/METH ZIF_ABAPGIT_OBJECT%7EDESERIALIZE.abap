  METHOD zif_abapgit_object~deserialize.

    DATA: lv_dsonam      TYPE c LENGTH 30,
          lr_details     TYPE REF TO data,
          lr_infoobjects TYPE REF TO data,
          lr_navigation  TYPE REF TO data,
          lr_indexes     TYPE REF TO data,
          lr_index_iobj  TYPE REF TO data,
          lt_return      TYPE STANDARD TABLE OF bapiret2,
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

    io_xml->read( EXPORTING iv_name = 'ODSO'
                  CHANGING  cg_data = <lg_details> ).

    io_xml->read( EXPORTING iv_name = 'INFOOBJECTS'
                  CHANGING  cg_data =  <lt_infoobjects> ).

    io_xml->read( EXPORTING iv_name = 'NAVIGATION'
                  CHANGING  cg_data =  <lt_navigation> ).

    io_xml->read( EXPORTING iv_name = 'INDEXES'
                  CHANGING  cg_data =  <lt_indexes> ).

    io_xml->read( EXPORTING iv_name = 'INDEX_IOBJ'
                  CHANGING  cg_data =  <lt_index_iobj> ).
    TRY.
        CALL FUNCTION 'BAPI_ODSO_CREATE'
          EXPORTING
            details              = <lg_details>
          IMPORTING
            odsobject            = lv_dsonam
          TABLES
            infoobjects          = <lt_infoobjects>
            navigationattributes = <lt_navigation>
            indexes              = <lt_indexes>
            indexesinfoobjects   = <lt_index_iobj>
            return               = lt_return.

      CATCH  cx_sy_dyn_call_illegal_func.
        zcx_abapgit_exception=>raise( |Necessary BW function modules not found or object not supported| ).
    ENDTRY.

    READ TABLE lt_return WITH KEY type = 'E' INTO ls_return.
    IF sy-subrc = 0.
      zcx_abapgit_exception=>raise( |Error when creating ODSO: { ls_return-message }| ).
    ENDIF.

    CALL FUNCTION 'BAPI_ODSO_ACTIVATE'
      EXPORTING
        odsobject = lv_dsonam
      TABLES
        return    = lt_return.

    READ TABLE lt_return WITH KEY type = 'E' INTO ls_return.
    IF sy-subrc = 0.
      zcx_abapgit_exception=>raise( |Error when activating ODSO: { ls_return-message }| ).
    ENDIF.

    tadir_insert( iv_package ).

    corr_insert( iv_package ).

  ENDMETHOD.