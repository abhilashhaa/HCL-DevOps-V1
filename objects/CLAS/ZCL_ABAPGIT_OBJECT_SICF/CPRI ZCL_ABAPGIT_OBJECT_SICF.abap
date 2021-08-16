  PRIVATE SECTION.

    TYPES:
      ty_icfhandler_tt TYPE STANDARD TABLE OF icfhandler WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_sicf_key,
        icf_name   TYPE icfservice-icf_name,
        icfparguid TYPE icfservice-icfparguid,
      END OF ty_sicf_key .

    METHODS read
      IMPORTING
        !iv_clear      TYPE abap_bool DEFAULT abap_true
      EXPORTING
        !es_icfservice TYPE icfservice
        !es_icfdocu    TYPE icfdocu
        !et_icfhandler TYPE ty_icfhandler_tt
        !ev_url        TYPE string
      RAISING
        zcx_abapgit_exception .
    METHODS insert_sicf
      IMPORTING
        !is_icfservice TYPE icfservice
        !is_icfdocu    TYPE icfdocu
        !it_icfhandler TYPE ty_icfhandler_tt
        !iv_package    TYPE devclass
        !iv_url        TYPE string
      RAISING
        zcx_abapgit_exception .
    METHODS change_sicf
      IMPORTING
        !is_icfservice TYPE icfservice
        !is_icfdocu    TYPE icfdocu
        !it_icfhandler TYPE ty_icfhandler_tt
        !iv_package    TYPE devclass
        !iv_parent     TYPE icfparguid
      RAISING
        zcx_abapgit_exception .
    METHODS to_icfhndlist
      IMPORTING
        !it_list       TYPE ty_icfhandler_tt
      RETURNING
        VALUE(rt_list) TYPE icfhndlist .
    METHODS find_parent
      IMPORTING
        !iv_url          TYPE string
      RETURNING
        VALUE(rv_parent) TYPE icfparguid
      RAISING
        zcx_abapgit_exception .