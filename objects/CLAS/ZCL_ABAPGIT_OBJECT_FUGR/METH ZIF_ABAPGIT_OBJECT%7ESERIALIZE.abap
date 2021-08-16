  METHOD zif_abapgit_object~serialize.

* function group SEUF
* function group SIFP
* function group SUNI

    DATA: lt_functions    TYPE ty_function_tt,
          ls_progdir      TYPE ty_progdir,
          lv_program_name TYPE programm,
          lt_dynpros      TYPE ty_dynpro_tt,
          ls_cua          TYPE ty_cua.

    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    serialize_xml( io_xml ).

    lt_functions = serialize_functions( ).
    io_xml->add( iv_name = 'FUNCTIONS'
                 ig_data = lt_functions ).

    serialize_includes( ).

    lv_program_name = main_name( ).
    ls_progdir = read_progdir( lv_program_name ).

    serialize_texts( iv_prog_name = lv_program_name
                     ii_xml       = io_xml ).

    IF ls_progdir-subc = 'F'.
      lt_dynpros = serialize_dynpros( lv_program_name ).
      io_xml->add( iv_name = 'DYNPROS'
                   ig_data = lt_dynpros ).

      ls_cua = serialize_cua( lv_program_name ).
      io_xml->add( iv_name = 'CUA'
                   ig_data = ls_cua ).
    ENDIF.

  ENDMETHOD.