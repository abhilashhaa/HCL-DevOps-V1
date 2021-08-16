  METHOD zif_abapgit_object~deserialize.

    DATA: li_interface TYPE REF TO lif_package_interface_facade,
          ls_pinf      TYPE ty_pinf.


    io_xml->read( EXPORTING iv_name = 'PINF'
                  CHANGING cg_data = ls_pinf ).

    "needed for update_attributes
    ls_pinf-attributes-tadir_devc = iv_package.

    li_interface = create_or_load(
      is_pinf    = ls_pinf
      iv_package = iv_package ).

    update_attributes(
      iv_package   = iv_package
      is_pinf      = ls_pinf
      ii_interface = li_interface ).

    update_elements(
      is_pinf      = ls_pinf
      ii_interface = li_interface ).

  ENDMETHOD.