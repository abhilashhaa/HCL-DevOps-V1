class CL_NGC_DRF_EWM_CLS definition
  public
  create public .

public section.

  interfaces IF_DRF_OUTBOUND .

  types:
    tt_cls_key TYPE SORTED TABLE OF ngcs_drf_clsmas_object_key WITH UNIQUE KEY klart class .

  methods CONSTRUCTOR
    importing
      !IS_RUNTIME_PARAM type DRF_S_RUNTIME_PARAMETER_EXT .