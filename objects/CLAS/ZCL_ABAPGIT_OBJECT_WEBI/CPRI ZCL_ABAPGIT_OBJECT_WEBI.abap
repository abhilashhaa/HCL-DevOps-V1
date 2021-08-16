  PRIVATE SECTION.
    TYPES: BEGIN OF ty_webi,
             veptext         TYPE veptext,
             pvepheader      TYPE STANDARD TABLE OF vepheader WITH DEFAULT KEY,
             pvepfunction    TYPE STANDARD TABLE OF vepfunction WITH DEFAULT KEY,
             pvepfault       TYPE STANDARD TABLE OF vepfault WITH DEFAULT KEY,
             pvepparameter   TYPE STANDARD TABLE OF vepparameter WITH DEFAULT KEY,
             pveptype        TYPE STANDARD TABLE OF veptype WITH DEFAULT KEY,
             pvepelemtype    TYPE STANDARD TABLE OF vepelemtype WITH DEFAULT KEY,
             pveptabletype   TYPE STANDARD TABLE OF veptabletype WITH DEFAULT KEY,
             pvepstrutype    TYPE STANDARD TABLE OF vepstrutype WITH DEFAULT KEY,
             pveptypesoapext TYPE STANDARD TABLE OF veptypesoapext WITH DEFAULT KEY,
             pvepeletypsoap  TYPE STANDARD TABLE OF vepeletypsoap WITH DEFAULT KEY,
             pveptabtypsoap  TYPE STANDARD TABLE OF veptabtypsoap WITH DEFAULT KEY,
             pvepfuncsoapext TYPE STANDARD TABLE OF vepfuncsoapext WITH DEFAULT KEY,
             pvepfieldref    TYPE STANDARD TABLE OF vepfieldref WITH DEFAULT KEY,
             pvependpoint    TYPE STANDARD TABLE OF vependpoint WITH DEFAULT KEY,
             pvepvisoapext   TYPE STANDARD TABLE OF vepvisoapext WITH DEFAULT KEY,
             pvepparasoapext TYPE STANDARD TABLE OF vepparasoapext WITH DEFAULT KEY,
             pwsheader       TYPE STANDARD TABLE OF wsheader WITH DEFAULT KEY,
             pwssoapprop     TYPE STANDARD TABLE OF wssoapprop WITH DEFAULT KEY,
           END OF ty_webi.

    DATA: mi_vi TYPE REF TO if_ws_md_vif.

    METHODS:
      handle_endpoint
        IMPORTING is_webi TYPE ty_webi
        RAISING   zcx_abapgit_exception
                  cx_ws_md_exception,
      handle_types
        IMPORTING is_webi TYPE ty_webi
        RAISING   zcx_abapgit_exception
                  cx_ws_md_exception,
      handle_soap
        IMPORTING is_webi TYPE ty_webi
        RAISING   zcx_abapgit_exception
                  cx_ws_md_exception,
      handle_function
        IMPORTING is_webi TYPE ty_webi
        RAISING   zcx_abapgit_exception
                  cx_ws_md_exception.
    METHODS handle_single_parameter
      IMPORTING
        iv_parameter_type   TYPE vepparamtype
        iv_name             TYPE vepparameter-vepparam
        ii_function         TYPE REF TO if_ws_md_vif_func
      RETURNING
        VALUE(ri_parameter) TYPE REF TO if_ws_md_vif_param
      RAISING
        zcx_abapgit_exception
        cx_ws_md_exception.
