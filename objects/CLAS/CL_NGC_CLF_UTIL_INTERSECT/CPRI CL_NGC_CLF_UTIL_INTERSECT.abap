private section.

  types:
    BEGIN OF ts_intersected_charcs_dom_val.
  TYPES: classtype TYPE klassenart.
  TYPES: clfnorganizationalarea	TYPE abteilung.
  INCLUDE TYPE: ngcs_characteristic AS characteristic_head.
  TYPES: domain_values TYPE ngct_characteristic_value.
  TYPES: END OF ts_intersected_charcs_dom_val .
  types:
    tt_intersected_charcs_dom_val TYPE STANDARD TABLE OF ts_intersected_charcs_dom_val WITH NON-UNIQUE KEY classtype charcinternalid .
  types:
    BEGIN OF ts_characteristic_ref .
  TYPES: classtype TYPE klassenart.
  TYPES: charcinternalid TYPE atinn.
  TYPES: characteristic_ref TYPE ngct_characteristic_ref.
  TYPES: END OF ts_characteristic_ref .
  types:
    tt_characteristic_ref TYPE STANDARD TABLE OF ts_characteristic_ref WITH NON-UNIQUE KEY classtype charcinternalid .
  types:
    tt_classtype_range TYPE RANGE OF klassenart .

  data MT_INTERSECTED_DOM_VAL type TT_INTERSECTED_CHARCS_DOM_VAL .
  data MT_CHARACTERISTIC_REF type TT_CHARACTERISTIC_REF .
  data MO_UTIL_INTERSECT type ref to IF_NGC_CORE_CLS_UTIL_INTERSECT .
  data MT_RECALCULATION_CLASSTYPE type NGCT_CLASS_TYPES .
  data MO_CLF_PERSISTENCY type ref to IF_NGC_CORE_CLF_PERSISTENCY .
  data MT_RECALC_CLASSTYPE_RANGE type TT_CLASSTYPE_RANGE .

  methods CALCULATE_CHARCS_AND_DOM_VALS
    importing
      !IT_CLASSES type NGCT_CLASS_OBJECT
      !IS_CLASSIFICATION_KEY type NGCS_CLASSIFICATION_KEY
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .