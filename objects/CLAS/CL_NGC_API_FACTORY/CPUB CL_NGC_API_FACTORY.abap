class CL_NGC_API_FACTORY definition
  public
  create protected .

public section.

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to CL_NGC_API_FACTORY .
  methods GET_API
    returning
      value(RO_API) type ref to IF_NGC_API .
  methods CREATE_CLASSIFICATION
    importing
      !IS_CLASSIFICATION_KEY type NGCS_CLASSIFICATION_KEY
      !IT_CLASSIFICATION_DATA type NGCT_CLASSIFICATION_DATA optional
      !IT_ASSIGNED_CLASSES type NGCT_CLASS_OBJECT optional
      !IT_VALUATION_DATA type NGCT_VALUATION_DATA optional
      !IT_ASSIGNED_CHARACTERISTICS type NGCT_CHARACTERISTIC_OBJECT optional
    returning
      value(RO_CLASSIFICATION) type ref to IF_NGC_CLASSIFICATION .
  methods CREATE_CHARACTERISTIC
    importing
      !IS_CHARACTERISTIC_HEADER type NGCS_CHARACTERISTIC
      !IT_CHARACTERISTIC_VALUE type NGCT_CHARACTERISTIC_VALUE optional
      !IT_CHARACTERISTIC_REF type NGCT_CHARACTERISTIC_REF optional
    returning
      value(RO_CHARACTERISTIC) type ref to IF_NGC_CHARACTERISTIC .
  methods CREATE_CLASS
    importing
      !IS_CLASS_HEADER type NGCS_CLASS
    returning
      value(RO_CLASS) type ref to IF_NGC_CLASS .
  methods CREATE_CLASS_WITH_CHARCS
    importing
      !IS_CLASS_HEADER type NGCS_CLASS
      !IT_CLASS_CHARACTERISTICS type NGCT_CLASS_CHARACTERISTIC
      !IT_CLASS_CHARACTERISTIC_VALUES type NGCT_CLASS_CHARC_VALUE optional
      !IT_CHARACTERISTIC_REF type NGCT_CHARACTERISTIC_REF optional
    returning
      value(RO_CLASS) type ref to IF_NGC_CLASS .