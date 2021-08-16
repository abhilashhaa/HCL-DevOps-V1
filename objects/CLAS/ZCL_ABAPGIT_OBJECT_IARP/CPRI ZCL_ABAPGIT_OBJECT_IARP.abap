  PRIVATE SECTION.
    DATA:
      ms_name     TYPE w3resokey.

    METHODS:
      read
        EXPORTING es_attributes TYPE w3resoattr
                  et_parameters TYPE w3resopara_tabletype
        RAISING   zcx_abapgit_exception,

      save
        IMPORTING is_attributes TYPE w3resoattr
                  it_parameters TYPE w3resopara_tabletype
        RAISING   zcx_abapgit_exception,

      w3_api_load
        RETURNING VALUE(ri_resource) TYPE REF TO if_w3_api_resource
        RAISING   zcx_abapgit_exception,

      w3_api_get_attributes
        IMPORTING ii_resource          TYPE REF TO if_w3_api_resource
        RETURNING VALUE(rs_attributes) TYPE w3resoattr
        RAISING   zcx_abapgit_exception,

      w3_api_get_parameters
        IMPORTING ii_resource          TYPE REF TO if_w3_api_resource
        RETURNING VALUE(rt_parameters) TYPE w3resopara_tabletype
        RAISING   zcx_abapgit_exception,

      w3_api_create_new
        IMPORTING is_attributes      TYPE w3resoattr
        RETURNING VALUE(ri_resource) TYPE REF TO if_w3_api_resource
        RAISING   zcx_abapgit_exception,

      w3_api_set_attributes
        IMPORTING ii_resource   TYPE REF TO if_w3_api_resource
                  is_attributes TYPE w3resoattr
        RAISING   zcx_abapgit_exception,

      w3_api_set_parameters
        IMPORTING ii_resource   TYPE REF TO if_w3_api_resource
                  it_parameters TYPE w3resopara_tabletype
        RAISING   zcx_abapgit_exception,

      w3_api_save
        IMPORTING ii_resource TYPE REF TO if_w3_api_resource
        RAISING
                  zcx_abapgit_exception,

      w3_api_set_changeable
        IMPORTING ii_resource TYPE REF TO if_w3_api_resource
        RAISING   zcx_abapgit_exception,

      w3_api_delete
        IMPORTING ii_resource TYPE REF TO if_w3_api_resource
        RAISING   zcx_abapgit_exception.
