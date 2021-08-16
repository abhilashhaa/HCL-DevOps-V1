  METHOD load.

    DATA: li_interface TYPE REF TO  if_package_interface.

    cl_package_interface=>load_package_interface(
      EXPORTING
        i_package_interface_name = iv_name
        i_force_reload           = abap_true
      IMPORTING
        e_package_interface      = li_interface ).

    ri_interface = create_facade( li_interface ).

  ENDMETHOD.