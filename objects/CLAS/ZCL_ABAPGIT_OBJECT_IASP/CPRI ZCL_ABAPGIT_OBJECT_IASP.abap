  PRIVATE SECTION.
    DATA:
      mv_name    TYPE itsappl.

    METHODS:
      read
        EXPORTING es_attr       TYPE w3servattr
                  et_parameters TYPE w3servpara_tabletype
        RAISING   zcx_abapgit_exception,

      save
        IMPORTING is_attr       TYPE w3servattr
                  it_parameters TYPE w3servpara_tabletype
        RAISING   zcx_abapgit_exception,

      w3_api_load
        RETURNING VALUE(ri_service) TYPE REF TO if_w3_api_service
        RAISING   zcx_abapgit_exception,

      w3_api_get_attributes
        IMPORTING ii_service           TYPE REF TO if_w3_api_service
        RETURNING VALUE(rs_attributes) TYPE w3servattr,

      w3_api_get_parameters
        IMPORTING ii_service           TYPE REF TO if_w3_api_service
        RETURNING VALUE(rt_parameters) TYPE w3servpara_tabletype,

      w3_api_create_new
        IMPORTING is_attributes     TYPE w3servattr
        RETURNING VALUE(ri_service) TYPE REF TO if_w3_api_service
        RAISING
                  zcx_abapgit_exception,

      w3_api_set_attributes
        IMPORTING ii_service    TYPE REF TO if_w3_api_service
                  is_attributes TYPE w3servattr
        RAISING   zcx_abapgit_exception,

      w3_api_set_parameters
        IMPORTING ii_service    TYPE REF TO if_w3_api_service
                  it_parameters TYPE w3servpara_tabletype
        RAISING   zcx_abapgit_exception,

      w3_api_save
        IMPORTING ii_service TYPE REF TO if_w3_api_service
        RAISING   zcx_abapgit_exception,

      w3_api_set_changeable
        IMPORTING ii_service TYPE REF TO if_w3_api_service
        RAISING   zcx_abapgit_exception,

      w3_api_delete
        IMPORTING ii_service TYPE REF TO if_w3_api_service
        RAISING   zcx_abapgit_exception.
