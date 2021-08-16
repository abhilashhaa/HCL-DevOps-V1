  PRIVATE SECTION.

    DATA:
      mt_hotkey_providers TYPE TABLE OF REF TO zif_abapgit_gui_hotkeys .
    CLASS-DATA gv_hint_was_shown TYPE abap_bool .
    CLASS-DATA gt_interface_implementations TYPE saboo_iimpt .

    CLASS-METHODS filter_relevant_classes
      IMPORTING
        !it_classes       TYPE seo_relkeys
      RETURNING
        VALUE(rt_classes) TYPE seo_relkeys .
    CLASS-METHODS get_class_package
      IMPORTING
        !iv_class_name    TYPE seoclsname
      RETURNING
        VALUE(rv_package) TYPE devclass .
    CLASS-METHODS get_referred_class_name
      IMPORTING
        !io_ref        TYPE any
      RETURNING
        VALUE(rv_name) TYPE seoclsname .
    CLASS-METHODS get_hotkeys_by_class_name
      IMPORTING
        !iv_class_name    TYPE seoclsname
      RETURNING
        VALUE(rt_hotkeys) TYPE zif_abapgit_gui_hotkeys=>tty_hotkey_with_descr .
    CLASS-METHODS get_hotkeys_from_global_intf
      RETURNING
        VALUE(rt_hotkeys) TYPE zif_abapgit_gui_hotkeys=>tty_hotkey_with_descr
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS get_hotkeys_from_local_intf
      RETURNING
        VALUE(rt_hotkeys) TYPE zif_abapgit_gui_hotkeys=>tty_hotkey_with_descr
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS get_local_intf_implementations
      RETURNING
        VALUE(rt_interface_implementations) TYPE saboo_iimpt
      RAISING
        zcx_abapgit_exception .
    METHODS render_scripts
      IMPORTING
        !it_hotkeys    TYPE zif_abapgit_gui_hotkeys=>tty_hotkey_with_descr
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .