  METHOD open_adt_stob.

    DATA: lr_data  TYPE REF TO data,
          lo_ddl   TYPE REF TO object,
          lx_error TYPE REF TO cx_root.

    FIELD-SYMBOLS: <lt_ddnames>     TYPE STANDARD TABLE.
    FIELD-SYMBOLS: <lt_entity_view> TYPE STANDARD TABLE.
    FIELD-SYMBOLS: <lg_ddnames>     TYPE any.
    FIELD-SYMBOLS: <lg_entity_view> TYPE any.
    FIELD-SYMBOLS: <lg_ddname>      TYPE any.
    FIELD-SYMBOLS: <lg_ddlname>     TYPE any.


    TRY.
        CREATE DATA lr_data TYPE ('IF_DD_DDL_TYPES=>TY_T_DDOBJ').
        ASSIGN lr_data->* TO <lt_ddnames>.

        CREATE DATA lr_data LIKE LINE OF <lt_ddnames>.
        ASSIGN lr_data->* TO <lg_ddnames>.

        CREATE DATA lr_data TYPE ('IF_DD_DDL_TYPES=>TY_T_ENTITY_OF_VIEW').
        ASSIGN lr_data->* TO <lt_entity_view>.

        CREATE DATA lr_data LIKE LINE OF <lt_entity_view>.
        ASSIGN lr_data->* TO <lg_entity_view>.

        CLEAR <lt_ddnames>.
        ASSIGN COMPONENT 'NAME' OF STRUCTURE <lg_ddnames> TO <lg_ddname>.
        <lg_ddname> = iv_ddls_name.
        INSERT <lg_ddnames> INTO TABLE <lt_ddnames>.

        CALL METHOD ('CL_DD_DDL_HANDLER_FACTORY')=>('CREATE')
          RECEIVING
            handler = lo_ddl.

        CALL METHOD lo_ddl->('IF_DD_DDL_HANDLER~GET_VIEWNAME_FROM_ENTITYNAME')
          EXPORTING
            ddnames        = <lt_ddnames>
          IMPORTING
            view_of_entity = <lt_entity_view>.

        READ TABLE <lt_entity_view> ASSIGNING <lg_entity_view> INDEX 1.
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'DDLNAME' OF STRUCTURE <lg_entity_view> TO <lg_ddlname>.

          jump_adt( iv_obj_name = <lg_ddlname>
                    iv_obj_type = 'DDLS' ).

        ENDIF.

      CATCH cx_root INTO lx_error.
        zcx_abapgit_exception=>raise( iv_text     = lx_error->get_text( )
                                      ix_previous = lx_error ).
    ENDTRY.

  ENDMETHOD.