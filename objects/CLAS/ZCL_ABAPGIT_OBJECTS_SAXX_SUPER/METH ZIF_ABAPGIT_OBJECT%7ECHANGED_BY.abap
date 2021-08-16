  METHOD zif_abapgit_object~changed_by.

    DATA: lr_data TYPE REF TO data.

    FIELD-SYMBOLS: <lg_data>       TYPE any,
                   <lg_header>     TYPE any,
                   <lg_changed_by> TYPE any.

    create_channel_objects( ).

    TRY.
        CREATE DATA lr_data TYPE (mv_data_structure_name).
        ASSIGN lr_data->* TO <lg_data>.

      CATCH cx_root.
        zcx_abapgit_exception=>raise( |{ ms_item-obj_name } not supported| ).
    ENDTRY.

    get_data( IMPORTING eg_data = <lg_data> ).

    ASSIGN COMPONENT 'HEADER' OF STRUCTURE <lg_data> TO <lg_header>.
    ASSERT sy-subrc = 0.
    ASSIGN COMPONENT 'CHANGED_BY' OF STRUCTURE <lg_header> TO <lg_changed_by>.
    ASSERT sy-subrc = 0.

    IF <lg_changed_by> IS NOT INITIAL.
      rv_user = <lg_changed_by>.
    ELSE.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.