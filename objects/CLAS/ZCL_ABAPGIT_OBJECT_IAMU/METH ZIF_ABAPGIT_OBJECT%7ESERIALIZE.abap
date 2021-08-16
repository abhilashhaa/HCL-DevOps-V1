  METHOD zif_abapgit_object~serialize.

    DATA: ls_internet_appl_comp_binary TYPE ty_internet_appl_comp_binary.

    ls_internet_appl_comp_binary = read( ).

    io_xml->add( iv_name = 'IAMU'
                 ig_data = ls_internet_appl_comp_binary ).

  ENDMETHOD.