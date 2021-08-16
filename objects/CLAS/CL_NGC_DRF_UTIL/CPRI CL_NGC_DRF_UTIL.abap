private section.

  types:
    BEGIN OF ty_s_classification,
      objek TYPE cuobn,
      klart TYPE klassenart,
      mafid TYPE klmaf,
      datuv TYPE datuv,
      obtab TYPE tabelle,
    END OF ty_s_classification .
  types:
    ty_t_classification TYPE STANDARD TABLE OF ty_s_classification .

  class-data GO_INSTANCE type ref to CL_NGC_DRF_UTIL .
  data MO_SELECTION_UTIL type ref to LIF_SELECTION_UTIL .
  data MO_DB_ACCESS type ref to LIF_DB_ACCESS .
  data MV_REPLICATION_MODE type DRF_DLMOD value IF_DRF_CONST=>MODE_DIRECTLY ##NO_TEXT.

  methods CONSTRUCTOR
    importing
      !IV_REPLICATION_MODE type DRF_DLMOD default IF_DRF_CONST=>MODE_DIRECTLY .
  methods GET_WHERE_COND_FROM_SEL_CRIT
    importing
      !IT_SELECTION_CRITERIA type RSDS_TRANGE
    exporting
      !ET_WHERE_CONDITION type RSDS_TWHERE .
  class-methods GET_SELECTED_CLASSIFICATIONS
    importing
      !IT_WHERE_CONDITION type RSDS_TWHERE optional
      !IT_SELECTION_CRITERIA type RSDS_TRANGE optional
    exporting
      !ET_CLF_KEY type NGCT_DRF_CLFMAS_OBJECT_KEY .
  class-methods SELECT_FROM_KSSK
    importing
      !IT_TCLA type TT_TCLA
      !IV_WHERE type BOOLE_D default ABAP_FALSE
      !IT_WHERE type RSDS_WHERE_TAB
    exporting
      !ET_CLASSIFICATION type TY_T_CLASSIFICATION .
  class-methods SELECT_FROM_TCLA
    importing
      !IT_SELECTION_CRITERIA type RSDS_TRANGE
    exporting
      !ET_TCLA type TT_TCLA .