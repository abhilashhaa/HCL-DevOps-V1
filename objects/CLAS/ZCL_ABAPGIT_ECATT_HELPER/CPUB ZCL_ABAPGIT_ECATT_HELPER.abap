CLASS zcl_abapgit_ecatt_helper DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:
      build_xml_of_object
        IMPORTING
          iv_object_name       TYPE etobj_name
          iv_object_version    TYPE etobj_ver
          iv_object_type       TYPE etobj_type
          io_download          TYPE REF TO cl_apl_ecatt_download
        RETURNING
          VALUE(rv_xml_stream) TYPE xstring
        RAISING
          zcx_abapgit_exception,

      download_data
        IMPORTING
          ii_template_over_all TYPE REF TO if_ixml_document
        RETURNING
          VALUE(rv_xml_stream) TYPE xstring,

      upload_data_from_stream
        IMPORTING
          iv_xml_stream               TYPE xstring
        RETURNING
          VALUE(ri_template_over_all) TYPE REF TO if_ixml_document
        RAISING
          cx_ecatt_apl_xml.
