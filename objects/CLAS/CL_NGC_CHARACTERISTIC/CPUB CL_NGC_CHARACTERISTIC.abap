class CL_NGC_CHARACTERISTIC definition
  public
  create public .

public section.

  interfaces IF_NGC_CHARACTERISTIC .

  methods CONSTRUCTOR
    importing
      !IS_CHARACTERISTIC_HEADER type NGCS_CHARACTERISTIC
      !IT_CHARACTERISTIC_VALUE type NGCT_CHARACTERISTIC_VALUE optional
      !IT_CHARACTERISTIC_REF type NGCT_CHARACTERISTIC_REF optional .