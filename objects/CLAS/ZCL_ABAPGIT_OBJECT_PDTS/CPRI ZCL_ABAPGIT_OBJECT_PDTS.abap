  PRIVATE SECTION.

    CONSTANTS: c_object_type_task       TYPE hr_sotype VALUE 'TS'.

    DATA ms_objkey TYPE hrsobject.
    DATA mv_objid TYPE hrobjid.

    METHODS check_subrc_for IMPORTING iv_call TYPE clike OPTIONAL
                            RAISING   zcx_abapgit_exception.

    METHODS is_experimental RETURNING VALUE(rv_result) TYPE abap_bool.
    METHODS get_container_xml
      IMPORTING
        ii_task                 TYPE REF TO lif_task_definition
      RETURNING
        VALUE(ri_first_element) TYPE REF TO if_ixml_element
      RAISING
        zcx_abapgit_exception.

    METHODS extract_container IMPORTING io_xml           TYPE REF TO zif_abapgit_xml_input
                              RETURNING VALUE(rv_result) TYPE xstring.
