class ZCL_ZSUP_TEST_MATERIAL_DPC_EXT definition
  public
  inheriting from ZCL_ZSUP_TEST_MATERIAL_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_SOST_SRV_RUNTIME~OPERATION_START
    redefinition .
  methods /IWBEP/IF_MGW_SOST_SRV_RUNTIME~OPERATION_END
    redefinition .