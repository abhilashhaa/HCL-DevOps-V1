class CL_API_CLFN_PRODUCT_DPC_EXT definition
  public
  inheriting from CL_API_CLFN_PRODUCT_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CREATE_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_CORE_SRV_RUNTIME~UPDATE_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_CORE_SRV_RUNTIME~DELETE_ENTITY
    redefinition .