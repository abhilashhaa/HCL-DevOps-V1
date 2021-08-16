  METHOD zif_abapgit_object~serialize.

    DATA: li_object_data  TYPE REF TO if_wb_object_data_model,
          li_srfc_persist TYPE REF TO if_wb_object_persist,
          lr_srfc_data    TYPE REF TO data,
          lx_error        TYPE REF TO cx_root,
          lv_text         TYPE string.

    FIELD-SYMBOLS: <lg_srfc_data> TYPE any,
                   <lg_any>       TYPE any.


    TRY.
        CREATE DATA lr_srfc_data TYPE ('UCONRFCSERV_COMPLETE').
        ASSIGN lr_srfc_data->* TO <lg_srfc_data>.
        ASSERT sy-subrc = 0.

        CREATE OBJECT li_srfc_persist TYPE ('CL_UCONRFC_OBJECT_PERSIST').

        li_srfc_persist->get(
          EXPORTING
            p_object_key  = |{ ms_item-obj_name }|
            p_version     = 'A'
          CHANGING
            p_object_data = li_object_data ).

        li_object_data->get_data( IMPORTING p_data = <lg_srfc_data> ).


        ASSIGN COMPONENT 'HEADER-CREATEDBY' OF STRUCTURE <lg_srfc_data> TO <lg_any>.
        IF sy-subrc = 0.
          CLEAR <lg_any>.
        ENDIF.

        ASSIGN COMPONENT 'HEADER-CREATEDON' OF STRUCTURE <lg_srfc_data> TO <lg_any>.
        IF sy-subrc = 0.
          CLEAR <lg_any>.
        ENDIF.

        ASSIGN COMPONENT 'HEADER-CREATEDAT' OF STRUCTURE <lg_srfc_data> TO <lg_any>.
        IF sy-subrc = 0.
          CLEAR <lg_any>.
        ENDIF.

      CATCH cx_root INTO lx_error.
        lv_text = lx_error->get_text( ).
        zcx_abapgit_exception=>raise( lv_text ).
    ENDTRY.

    io_xml->add( iv_name = 'SRFC'
                 ig_data = <lg_srfc_data> ).

  ENDMETHOD.