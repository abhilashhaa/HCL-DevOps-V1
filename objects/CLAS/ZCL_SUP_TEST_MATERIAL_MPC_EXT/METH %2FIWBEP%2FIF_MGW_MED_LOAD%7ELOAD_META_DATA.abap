  METHOD /iwbep/if_mgw_med_load~load_meta_data.

*** Enable soft state mode
Cs_header-soft_state_enabled = abap_true.


**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_MED_LOAD~LOAD_META_DATA
*  EXPORTING
*    IV_VERSION             =
*    IV_TECHNICAL_NAME      =
*  CHANGING
*    CS_HEADER              =
*    CT_NODES               =
*    CT_REFERENCES          =
*    CT_OPERATIONS          =
*    CT_TEXT_KEYS           =
*    CT_DOCUMENTATION       =
*    CT_PRIVATE_ANNOTATIONS =
*    CT_PUBLIC_ANNOTATIONS  =
*    CT_MAPPING             =
**    ct_model_usage         =
*    CT_MODEL_USAGES        =
*    CT_TAGS                =
*    CS_VOCAN_MODEL         =
*    .
**  CATCH /iwbep/cx_mgw_med_exception.
**ENDTRY.
  ENDMETHOD.