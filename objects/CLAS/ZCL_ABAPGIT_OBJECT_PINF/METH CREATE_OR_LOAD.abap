  METHOD create_or_load.

    DATA: li_interface          TYPE REF TO if_package_interface,
          lv_pkg_interface_data TYPE scompidtln.

    lv_pkg_interface_data-default_if = is_pinf-attributes-default_if.
    lv_pkg_interface_data-tadir_devc = iv_package.

    "Important if the package name comes from another package
    IF is_pinf-attributes-pack_name IS INITIAL.
      lv_pkg_interface_data-pack_name = iv_package.
    ELSE.
      lv_pkg_interface_data-pack_name = is_pinf-attributes-pack_name.
    ENDIF.

    IF zif_abapgit_object~exists( ) = abap_false.
      cl_package_interface=>create_new_package_interface(
        EXPORTING
          i_pkg_interface_name    = is_pinf-attributes-intf_name
          i_publisher_pkg_name    = lv_pkg_interface_data-pack_name
          i_pkg_interface_data    = lv_pkg_interface_data
        IMPORTING
          e_package_interface     = li_interface
        EXCEPTIONS
          object_already_existing = 1
          object_just_created     = 2
          interface_name_invalid  = 3
          unexpected_error        = 4
          OTHERS                  = 7 ).
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'error creating new package interface' ).
      ENDIF.

      ri_interface = create_facade( li_interface ).

    ELSE.

      ri_interface = load( is_pinf-attributes-intf_name ).

    ENDIF.

  ENDMETHOD.