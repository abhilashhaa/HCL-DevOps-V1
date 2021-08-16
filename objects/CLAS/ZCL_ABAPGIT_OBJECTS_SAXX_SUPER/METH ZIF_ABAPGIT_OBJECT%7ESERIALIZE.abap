  METHOD zif_abapgit_object~serialize.

    DATA: lr_data             TYPE REF TO data.

    FIELD-SYMBOLS: <lg_data>   TYPE any,
                   <lg_header> TYPE any,
                   <lg_field>  TYPE any.

    create_channel_objects( ).

    TRY.
        CREATE DATA lr_data TYPE (mv_data_structure_name).
        ASSIGN lr_data->* TO <lg_data>.

      CATCH cx_root.
        zcx_abapgit_exception=>raise( |{ ms_item-obj_type } not supported| ).
    ENDTRY.

    get_data( IMPORTING eg_data = <lg_data> ).

    ASSIGN COMPONENT 'HEADER' OF STRUCTURE <lg_data> TO <lg_header>.
    ASSERT sy-subrc = 0.

    ASSIGN COMPONENT 'CHANGED_ON' OF STRUCTURE <lg_header> TO <lg_field>.
    ASSERT sy-subrc = 0.
    CLEAR <lg_field>.

    ASSIGN COMPONENT 'CHANGED_BY' OF STRUCTURE <lg_header> TO <lg_field>.
    ASSERT sy-subrc = 0.
    CLEAR <lg_field>.

    ASSIGN COMPONENT 'CHANGED_AT' OF STRUCTURE <lg_header> TO <lg_field>.
    ASSERT sy-subrc = 0.
    CLEAR <lg_field>.

    ASSIGN COMPONENT 'CHANGED_CLNT' OF STRUCTURE <lg_header> TO <lg_field>.
    ASSERT sy-subrc = 0.
    CLEAR <lg_field>.

    ASSIGN COMPONENT 'CREATED_ON' OF STRUCTURE <lg_header> TO <lg_field>.
    ASSERT sy-subrc = 0.
    CLEAR <lg_field>.

    ASSIGN COMPONENT 'CREATED_BY' OF STRUCTURE <lg_header> TO <lg_field>.
    ASSERT sy-subrc = 0.
    CLEAR <lg_field>.

    ASSIGN COMPONENT 'CREATED_AT' OF STRUCTURE <lg_header> TO <lg_field>.
    ASSERT sy-subrc = 0.
    CLEAR <lg_field>.

    ASSIGN COMPONENT 'CREATED_CLNT' OF STRUCTURE <lg_header> TO <lg_field>.
    ASSERT sy-subrc = 0.
    CLEAR <lg_field>.

    io_xml->add( iv_name = ms_item-obj_type
                 ig_data = <lg_data> ).

  ENDMETHOD.