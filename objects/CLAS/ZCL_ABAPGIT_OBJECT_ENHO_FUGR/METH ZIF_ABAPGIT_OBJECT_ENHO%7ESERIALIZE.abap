  METHOD zif_abapgit_object_enho~serialize.

    DATA: lo_fugrdata  TYPE REF TO cl_enh_tool_fugr,
          lv_fugr_name TYPE rs38l-area,
          ls_enha_data TYPE enhfugrdata.

    FIELD-SYMBOLS: <ls_docuobj> TYPE enhfugrparamdocu.


    lo_fugrdata ?= ii_enh_tool.

    lo_fugrdata->get_fugr( IMPORTING fugr_name = lv_fugr_name ).

    TRY.
        lo_fugrdata->get_all_data_for_fugr(
          EXPORTING
            fugr_name = lv_fugr_name
          IMPORTING
            enha_data = ls_enha_data ).

        LOOP AT ls_enha_data-docuobjs ASSIGNING <ls_docuobj>.
          CLEAR: <ls_docuobj>-shorttext,
                 <ls_docuobj>-longtext.
        ENDLOOP.

      CATCH cx_enh_not_found.
        zcx_abapgit_exception=>raise( |error deserializing ENHO fugrdata { ms_item-obj_name }| ).
    ENDTRY.

    ii_xml->add( iv_name = 'TOOL'
                 ig_data = lo_fugrdata->if_enh_tool~get_tool( ) ).

    ii_xml->add( iv_name = 'FUGRDATA'
                 ig_data = ls_enha_data ).

  ENDMETHOD.