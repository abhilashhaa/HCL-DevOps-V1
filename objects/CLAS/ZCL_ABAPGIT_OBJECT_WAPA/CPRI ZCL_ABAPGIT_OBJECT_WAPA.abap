  PRIVATE SECTION.
    TYPES: BEGIN OF ty_page,
             attributes     TYPE o2pagattr,
             event_handlers TYPE o2pagevh_tabletype,
             parameters     TYPE o2pagpar_tabletype,
             types          TYPE rswsourcet,
           END OF ty_page.

    TYPES: ty_pages_tt TYPE STANDARD TABLE OF ty_page WITH DEFAULT KEY.

    CONSTANTS: c_active TYPE so2_version VALUE 'A'.

    METHODS:
      get_page_content
        IMPORTING io_page           TYPE REF TO cl_o2_api_pages
        RETURNING VALUE(rv_content) TYPE xstring
        RAISING   zcx_abapgit_exception,
      to_page_content
        IMPORTING iv_content        TYPE xstring
        RETURNING VALUE(rt_content) TYPE o2pageline_table,
      read_page
        IMPORTING is_page        TYPE o2pagattr
        RETURNING VALUE(rs_page) TYPE ty_page
        RAISING   zcx_abapgit_exception,
      create_new_application
        IMPORTING is_attributes TYPE o2applattr
                  it_nodes      TYPE o2applnode_table
                  it_navgraph   TYPE o2applgrap_table
        RETURNING VALUE(ro_bsp) TYPE REF TO cl_o2_api_application
        RAISING   zcx_abapgit_exception,
      create_new_page
        IMPORTING
          is_page_attributes TYPE o2pagattr
        RETURNING
          VALUE(ro_page)     TYPE REF TO cl_o2_api_pages
        RAISING
          zcx_abapgit_exception,
      delete_superfluous_pages
        IMPORTING
          it_local_pages  TYPE o2pagelist
          it_remote_pages TYPE ty_pages_tt
        RAISING
          zcx_abapgit_exception.
