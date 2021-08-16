  METHOD zif_abapgit_object~deserialize.

    DATA: lv_program_name TYPE programm,
          ls_progdir      TYPE ty_progdir,
          lt_tpool        TYPE textpool_table,
          lt_dynpros      TYPE ty_dynpro_tt,
          lt_tpool_ext    TYPE zif_abapgit_definitions=>ty_tpool_tt,
          ls_cua          TYPE ty_cua,
          lt_source       TYPE abaptxt255_tab.

    lv_program_name = ms_item-obj_name.

    lt_source = mo_files->read_abap( ).

    io_xml->read( EXPORTING iv_name = 'TPOOL'
                  CHANGING cg_data = lt_tpool_ext ).
    lt_tpool = read_tpool( lt_tpool_ext ).

    io_xml->read( EXPORTING iv_name = 'PROGDIR'
                  CHANGING cg_data  = ls_progdir ).
    deserialize_program( is_progdir = ls_progdir
                         it_source  = lt_source
                         it_tpool   = lt_tpool
                         iv_package = iv_package ).

    io_xml->read( EXPORTING iv_name = 'DYNPROS'
                  CHANGING cg_data  = lt_dynpros ).
    deserialize_dynpros( lt_dynpros ).

    io_xml->read( EXPORTING iv_name = 'CUA'
                  CHANGING cg_data  = ls_cua ).
    deserialize_cua( iv_program_name = lv_program_name
                     is_cua = ls_cua ).

    " Texts deserializing (English)
    deserialize_textpool( iv_program = lv_program_name
                          it_tpool   = lt_tpool ).

    " Texts deserializing (translations)
    deserialize_texts( io_xml ).

    deserialize_longtexts( io_xml ).

  ENDMETHOD.