CLASS zcl_abapgit_gui_repo_over DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_gui_component
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_gui_renderable .
    DATA: mv_order_by         TYPE string READ-ONLY.

    METHODS constructor
      RAISING zcx_abapgit_exception.
    METHODS set_order_by
      IMPORTING
        iv_order_by TYPE string.
    METHODS set_order_direction
      IMPORTING
        iv_order_descending TYPE abap_bool.

    METHODS set_filter
      IMPORTING
        it_postdata TYPE cnht_post_data_tab.

    METHODS has_favorites
      RETURNING VALUE(rv_has_favorites) TYPE abap_bool.
