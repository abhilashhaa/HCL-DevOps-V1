  METHOD zif_abapgit_object~deserialize.

    DATA: ls_outline TYPE wdy_cfg_outline_data,
          lt_data    TYPE wdy_cfg_persist_data_appl_tab.

    io_xml->read( EXPORTING iv_name = 'OUTLINE'
                  CHANGING  cg_data = ls_outline ).
    io_xml->read( EXPORTING iv_name = 'DATA'
                  CHANGING  cg_data = lt_data ).

    save( is_outline = ls_outline
          it_data    = lt_data
          iv_package = iv_package ).

  ENDMETHOD.