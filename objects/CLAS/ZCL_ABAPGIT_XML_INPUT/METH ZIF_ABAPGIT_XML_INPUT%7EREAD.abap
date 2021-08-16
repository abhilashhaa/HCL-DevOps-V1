  METHOD zif_abapgit_xml_input~read.

    DATA: lx_error TYPE REF TO cx_transformation_error,
          lt_rtab  TYPE abap_trans_resbind_tab.

    FIELD-SYMBOLS: <ls_rtab> LIKE LINE OF lt_rtab.

    ASSERT NOT iv_name IS INITIAL.

    CLEAR cg_data. "Initialize result to avoid problems with empty values

    APPEND INITIAL LINE TO lt_rtab ASSIGNING <ls_rtab>.
    <ls_rtab>-name = iv_name.
    GET REFERENCE OF cg_data INTO <ls_rtab>-value.

    TRY.
        CALL TRANSFORMATION id
          OPTIONS value_handling = 'accept_data_loss'
          SOURCE XML mi_xml_doc
          RESULT (lt_rtab).
      CATCH cx_transformation_error INTO lx_error.
        IF mv_filename IS INITIAL.
          zcx_abapgit_exception=>raise( lx_error->if_message~get_text( ) ).
        ELSE.
          zcx_abapgit_exception=>raise( |File { mv_filename }: { lx_error->if_message~get_text( ) }| ).
        ENDIF.
    ENDTRY.

  ENDMETHOD.