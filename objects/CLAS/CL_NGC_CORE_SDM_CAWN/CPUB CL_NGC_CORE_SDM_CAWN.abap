class CL_NGC_CORE_SDM_CAWN definition
  public
  inheriting from CL_SDM_PACKAGE_MIGRATION
  final
  create public .

public section.

  interfaces IF_SDM_NZDT .

  methods IF_SDM_MIGRATION~GET_PACKAGE_SIZE
    redefinition .
  methods IF_SDM_MIGRATION~GET_SELECTIVE_FIELD
    redefinition .
  methods IF_SDM_MIGRATION~GET_STATUS_FIELD
    redefinition .
  methods IF_SDM_MIGRATION~GET_STATUS_VALUE_DONE
    redefinition .
  methods IF_SDM_MIGRATION~GET_TABLE_NAME
    redefinition .
  methods IF_SDM_MIGRATION~MIGRATE_DATA
    redefinition .
  methods IF_SDM_MIGRATION~MIGRATE_DATA_FINISHED
    redefinition .
  methods IF_SDM_MIGRATION~MUST_RUN
    redefinition .