  PRIVATE SECTION.
    DATA:
      mv_xml_stream  TYPE xstring,
      mi_script_node TYPE REF TO if_ixml_element.

    METHODS:
      set_script_to_template
        RAISING
          cx_ecatt_apl_util,

      set_control_data_for_tcd
        IMPORTING
          is_param  TYPE etpar_gui
          io_params TYPE REF TO cl_apl_ecatt_params
        RAISING
          cx_ecatt_apl,

      escape_control_data
        IMPORTING
          ii_element TYPE REF TO if_ixml_element
          iv_tabname TYPE string
          iv_node    TYPE string
        RAISING
          cx_ecatt_apl_util,

      set_blob_to_template
        RAISING
          cx_ecatt_apl_util,

      set_artmp_to_template
        RAISING
          cx_ecatt_apl_util.
