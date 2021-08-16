interface IF_NGC_DRF_UTIL
  public .


  types:
    tt_atinn type STANDARD TABLE OF atinn .

  methods GET_SELECTED_CLASSIFICATIONS
    importing
      !IT_SELECTION_CRITERIA type RSDS_TRANGE optional
    exporting
      !ET_CLF_KEY type NGCT_DRF_CLFMAS_OBJECT_KEY .
  methods GET_SELECTED_CLASSES
    importing
      !IT_RANGE_KLART type RSDSSELOPT_T optional
      !IT_RANGE_CLASS type RSDSSELOPT_T optional
      !IV_ADDITIONAL_WHERE_CND type STRING optional
    exporting
      !ET_CLS_KEY type NGCT_DRF_CLSMAS_OBJECT_KEY .
  methods GET_SELECTED_CHARACTERISTICS
    importing
      !IT_RANGE_ATNAM type RSDSSELOPT_T optional
      !IT_RANGE_KLART type RSDSSELOPT_T optional
      !IT_RANGE_CLASS type RSDSSELOPT_T optional
      !IV_ADDITIONAL_WHERE_CND type STRING optional
    exporting
      !ET_CHR_KEY type NGCT_DRF_CHRMAS_OBJECT_KEY .
  methods SET_CLASSIFICATION_DATA
    importing
      !IT_KSSK_CLASSIFICATION type TT_KSSK
      !IT_INOB_CLASSIFICATION type TT_INOB
      !IT_AUSP_CLASSIFICATION type TT_AUSP
      !IT_ATNAM_SOURCE_CLASSIFICATION type CIFCLATNAM_TAB
      !IT_CLASS_SOURCE_CLASSIFICATION type CIFCLCLASS_TAB .
  methods SET_CHARACTERISTIC_DATA
    importing
      !IT_CHARACT_TAB type TT_CABN
      !IT_CHARACT_DESCR_TAB type TT_CABNT
      !IT_VALUE_TAB type TT_CAWN
      !IT_VALUE_DESCR_TAB type TT_CAWNT
      !IT_RESTRICTIONS_TAB type TT_TCME
      !IT_REFERENCES_TAB type TT_CABNZ .
  methods SET_CLASS_DATA
    importing
      !IT_CLASS_HEADER type TT_KLAH
      !IV_KSML_UPDATE type BOOLE_D
      !IV_SWOR_UPDATE type BOOLE_D
      !IT_CHARACT_TAB type TT_KSML
      !IT_CATCHWORD_TAB type TT_SWOR
      !IT_CHARACT_TAB_O type TT_KSML .
  methods GET_CLASSIFICATION_DATA
    importing
      !IT_BO_KEYS type NGCT_DRF_CLFMAS_OBJECT_KEY optional
    exporting
      !ET_KSSK_CLASSIFICATION type TT_KSSK
      !ET_INOB_CLASSIFICATION type TT_INOB
      !ET_AUSP_CLASSIFICATION type TT_AUSP .
  methods GET_CHARACTERISTIC_DATA
    importing
      !IT_BO_KEYS type NGCT_DRF_CHRMAS_OBJECT_KEY optional
      !IT_ATINN type TT_ATINN optional
    exporting
      !ET_CHARACT_TAB type TT_CABN
      !ET_CHARACT_DESCR_TAB type TT_CABNT
      !ET_VALUE_TAB type TT_CAWN
      !ET_VALUE_DESCR_TAB type TT_CAWNT
      !ET_RESTRICTIONS_TAB type TT_TCME
      !ET_REFERENCES_TAB type TT_CABNZ .
  methods GET_CLASS_DATA
    importing
      !IT_BO_KEY type NGCT_DRF_CLSMAS_OBJECT_KEY optional
    exporting
      !ET_CLASS_HEADER type TT_KLAH
      !ET_CHARACT_TAB type TT_KSML
      !ET_CATCHWORD_TAB type TT_SWOR .
endinterface.