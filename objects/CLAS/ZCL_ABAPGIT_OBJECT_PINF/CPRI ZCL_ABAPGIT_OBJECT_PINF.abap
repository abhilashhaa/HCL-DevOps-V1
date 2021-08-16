  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_pinf,
        attributes TYPE scompidtln,
        elements   TYPE STANDARD TABLE OF scomeldtln WITH DEFAULT KEY,
      END OF ty_pinf .
    TYPES:
      ty_elements TYPE STANDARD TABLE OF tpak_package_interf_elem_ref WITH DEFAULT KEY .

    METHODS create_or_load
      IMPORTING
        !is_pinf            TYPE ty_pinf
        !iv_package         TYPE devclass
      RETURNING
        VALUE(ri_interface) TYPE REF TO lif_package_interface_facade
      RAISING
        zcx_abapgit_exception .
    METHODS delete_elements
      IMPORTING
        !ii_interface TYPE REF TO lif_package_interface_facade
      RAISING
        zcx_abapgit_exception .
    METHODS update_attributes
      IMPORTING
        !iv_package   TYPE devclass
        !is_pinf      TYPE ty_pinf
        !ii_interface TYPE REF TO lif_package_interface_facade
      RAISING
        zcx_abapgit_exception .
    METHODS update_elements
      IMPORTING
        is_pinf      TYPE ty_pinf
        ii_interface TYPE REF TO lif_package_interface_facade
      RAISING
        zcx_abapgit_exception .
    METHODS load
      IMPORTING
        iv_name             TYPE scomifnam
      RETURNING
        VALUE(ri_interface) TYPE REF TO lif_package_interface_facade.
    METHODS create_facade
      IMPORTING
        ii_interface     TYPE REF TO if_package_interface
      RETURNING
        VALUE(ri_facade) TYPE REF TO lif_package_interface_facade.
