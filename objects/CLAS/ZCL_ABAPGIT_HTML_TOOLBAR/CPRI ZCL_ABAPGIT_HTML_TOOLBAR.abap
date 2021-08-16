  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_item,
        txt   TYPE string,
        act   TYPE string,
        ico   TYPE string,
        sub   TYPE REF TO zcl_abapgit_html_toolbar,
        opt   TYPE char1,
        typ   TYPE char1,
        cur   TYPE abap_bool,
        chk   TYPE abap_bool,
        aux   TYPE string,
        id    TYPE string,
        title TYPE string,
      END OF ty_item .
    TYPES:
      tt_items TYPE STANDARD TABLE OF ty_item .

    DATA mt_items TYPE tt_items .
    DATA mv_id TYPE string .

    METHODS render_items
      IMPORTING
        !iv_sort       TYPE abap_bool OPTIONAL
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html .