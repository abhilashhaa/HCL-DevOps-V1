  PRIVATE SECTION.
    METHODS:
      read
        EXPORTING es_attr   TYPE w3tempattr
                  ev_source TYPE string
        RAISING   zcx_abapgit_exception,
      save
        IMPORTING is_attr   TYPE w3tempattr iv_source TYPE string
        RAISING   zcx_abapgit_exception,
      w3_api_load
        IMPORTING is_name     TYPE iacikeyt
        RETURNING VALUE(ri_template) TYPE REF TO if_w3_api_template
        RAISING   zcx_abapgit_exception,
      w3_api_set_changeable
        IMPORTING iv_changeable TYPE abap_bool
                  ii_template   TYPE REF TO if_w3_api_template
        RAISING   zcx_abapgit_exception,
      w3_api_delete
        IMPORTING ii_template TYPE REF TO if_w3_api_template
        RAISING   zcx_abapgit_exception,
      w3_api_save
        IMPORTING ii_template TYPE REF TO if_w3_api_template
        RAISING   zcx_abapgit_exception,
      w3_api_get_attributes
        IMPORTING ii_template   TYPE REF TO if_w3_api_template
        RETURNING VALUE(rs_attributes) TYPE w3tempattr
        RAISING   zcx_abapgit_exception,
      w3_api_get_source
        IMPORTING ii_template TYPE REF TO if_w3_api_template
        RETURNING VALUE(rt_source)   TYPE w3htmltabtype
        RAISING   zcx_abapgit_exception,
      w3_api_create_new
        IMPORTING is_template_data TYPE w3tempattr
        RETURNING VALUE(ri_template)      TYPE REF TO if_w3_api_template
        RAISING   zcx_abapgit_exception,
      w3_api_set_attributes
        IMPORTING ii_template TYPE REF TO if_w3_api_template
                  is_attr     TYPE w3tempattr
        RAISING   zcx_abapgit_exception,
      w3_api_set_source
        IMPORTING ii_template TYPE REF TO if_w3_api_template
                  it_source   TYPE w3htmltabtype
        RAISING   zcx_abapgit_exception.
