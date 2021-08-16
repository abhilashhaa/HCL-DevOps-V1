  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF c_proxy,
        data   TYPE string VALUE 'PROXY_DATA' ##NO_TEXT,
        header TYPE string VALUE 'PROXY_HEADER' ##NO_TEXT,
      END OF c_proxy .
    DATA mv_object TYPE sproxhdr-object .
    DATA mv_obj_name TYPE sproxhdr-obj_name .

    METHODS load_db
      RETURNING
        VALUE(rs_data) TYPE sprx_db_data .
    METHODS get_object_and_name
      EXPORTING
        !ev_object   TYPE sproxhdr-object
        !ev_obj_name TYPE sproxhdr-obj_name .
    METHODS delta_handling
      IMPORTING
        !ii_xml          TYPE REF TO zif_abapgit_xml_input
      EXPORTING
        !et_sproxhdr_new TYPE sprx_hdr_t
        !et_sproxdat_new TYPE sprx_dat_t
      RAISING
        zcx_abapgit_exception .
    METHODS check_sprx_tadir
      RAISING
        zcx_abapgit_exception .
    METHODS save
      IMPORTING
        !it_sproxhdr_new TYPE sprx_hdr_t
        !it_sproxdat_new TYPE sprx_dat_t .