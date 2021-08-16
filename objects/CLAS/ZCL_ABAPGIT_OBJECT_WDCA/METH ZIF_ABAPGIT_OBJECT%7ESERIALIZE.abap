  METHOD zif_abapgit_object~serialize.

    DATA: ls_outline TYPE wdy_cfg_outline_data,
          lt_data    TYPE wdy_cfg_persist_data_appl_tab.

    read( IMPORTING es_outline = ls_outline
                    et_data    = lt_data ).

    IF ls_outline IS INITIAL.
      RETURN.
    ENDIF.

    io_xml->add( iv_name = 'OUTLINE'
                 ig_data = ls_outline ).
    io_xml->add( iv_name = 'DATA'
                 ig_data = lt_data ).

  ENDMETHOD.