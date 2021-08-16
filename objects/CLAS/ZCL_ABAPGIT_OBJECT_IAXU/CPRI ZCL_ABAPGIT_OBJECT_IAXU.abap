  PRIVATE SECTION.
    DATA: mv_source_style_2006 TYPE w3style VALUE 'XML',
          mv_generator_class   TYPE w3styleclass VALUE 'CL_ITS_GENERATE_XML3'.

    METHODS:
      read
        RETURNING VALUE(rs_attr) TYPE w3tempattr
        RAISING   zcx_abapgit_exception,
      save
        IMPORTING is_attr TYPE w3tempattr
        RAISING   zcx_abapgit_exception,
      w3_api_load
        IMPORTING is_name    TYPE iacikeyt
        EXPORTING eo_xml_api TYPE REF TO object
                  es_attr    TYPE w3tempattr
        RAISING   zcx_abapgit_exception,
      w3_api_set_changeable
        IMPORTING io_xml_api    TYPE REF TO object
                  iv_changeable TYPE abap_bool
        RAISING   zcx_abapgit_exception,
      w3_api_delete
        IMPORTING io_xml_api TYPE REF TO object
        RAISING   zcx_abapgit_exception,
      w3_api_save
        IMPORTING io_xml_api TYPE REF TO object
        RAISING   zcx_abapgit_exception,
      w3_api_create_new
        IMPORTING is_attr           TYPE w3tempattr
        RETURNING VALUE(ro_xml_api) TYPE REF TO object
        RAISING   zcx_abapgit_exception.
