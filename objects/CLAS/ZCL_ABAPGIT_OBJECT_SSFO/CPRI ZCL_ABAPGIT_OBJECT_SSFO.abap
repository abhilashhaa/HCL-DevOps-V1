  PRIVATE SECTION.

    TYPES:
      ty_string_range TYPE RANGE OF string .

    CLASS-DATA gt_range_node_codes TYPE ty_string_range .
    CONSTANTS attrib_abapgit_leadig_spaces TYPE string VALUE 'abapgit-leadig-spaces' ##NO_TEXT.

    METHODS fix_ids
      IMPORTING
        !ii_xml_doc TYPE REF TO if_ixml_document .
    METHODS handle_attrib_leading_spaces
      IMPORTING
        !iv_name                TYPE string
        !ii_node                TYPE REF TO if_ixml_node
      CHANGING
        !cv_within_code_section TYPE abap_bool .
    METHODS get_range_node_codes
      RETURNING
        VALUE(rt_range_node_codes) TYPE ty_string_range .
    METHODS code_item_section_handling
      IMPORTING
        !iv_name                TYPE string
        !ii_node                TYPE REF TO if_ixml_node
      EXPORTING
        !ei_code_item_element   TYPE REF TO if_ixml_element
      CHANGING
        !cv_within_code_section TYPE abap_bool
      RAISING
        zcx_abapgit_exception .