  METHOD zif_abapgit_object~deserialize.

    DATA: lv_program_name TYPE programm,
          lt_functions    TYPE ty_function_tt,
          lt_dynpros      TYPE ty_dynpro_tt,
          ls_cua          TYPE ty_cua.

    deserialize_xml(
      ii_xml     = io_xml
      iv_package = iv_package ).

    io_xml->read( EXPORTING iv_name = 'FUNCTIONS'
                  CHANGING cg_data = lt_functions ).
    deserialize_functions(
      it_functions = lt_functions
      ii_log       = ii_log ).

    deserialize_includes(
      ii_xml     = io_xml
      iv_package = iv_package
      ii_log     = ii_log ).

    lv_program_name = main_name( ).

    deserialize_texts( iv_prog_name = lv_program_name
                       ii_xml       = io_xml ).

    io_xml->read( EXPORTING iv_name = 'DYNPROS'
                  CHANGING cg_data = lt_dynpros ).
    deserialize_dynpros( lt_dynpros ).

    io_xml->read( EXPORTING iv_name = 'CUA'
                  CHANGING cg_data = ls_cua ).
    deserialize_cua( iv_program_name = lv_program_name
                     is_cua = ls_cua ).

  ENDMETHOD.