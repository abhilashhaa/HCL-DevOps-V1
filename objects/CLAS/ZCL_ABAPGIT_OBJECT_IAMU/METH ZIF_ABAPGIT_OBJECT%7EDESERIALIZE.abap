  METHOD zif_abapgit_object~deserialize.

    DATA: ls_internet_appl_comp_binary TYPE ty_internet_appl_comp_binary.

    io_xml->read(
      EXPORTING
        iv_name = 'IAMU'
      CHANGING
        cg_data = ls_internet_appl_comp_binary ).

    ls_internet_appl_comp_binary-attributes-devclass = iv_package.

    save( ls_internet_appl_comp_binary ).

  ENDMETHOD.