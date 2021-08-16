class CL_NGC_CLASS definition
  public
  create public .

public section.

  interfaces IF_NGC_CLASS .

  methods CONSTRUCTOR
    importing
      !IS_CLASS_HEADER type NGCS_CLASS
      !IT_CLASS_CHARACTERISTICS type NGCT_CLASS_CHARACTERISTIC optional
      !IT_CLASS_CHARACTERISTIC_VALUES type NGCT_CLASS_CHARC_VALUE optional
      !IT_CHARACTERISTIC_REF type NGCT_CHARACTERISTIC_REF optional .