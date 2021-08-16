protected section.

  methods CONSTRUCTOR .
  methods GET_VALIDATORS_FOR_CLASS_TYPE
    importing
      !IV_CLASSTYPE type KLASSENART
    returning
      value(RT_VALIDATOR) type NGCT_CLASSIFICATION_VALIDATOR .