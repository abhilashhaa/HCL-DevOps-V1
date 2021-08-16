CLASS cl_ngc_classification DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_ngc_classification .
    INTERFACES if_ngc_clf_validation_dp .

    METHODS constructor
      IMPORTING
        !is_classification_key  TYPE ngcs_classification_key
        !it_classification_data TYPE ngct_classification_data OPTIONAL
        !it_assigned_classes    TYPE ngct_class_object OPTIONAL
        !it_valuation_data      TYPE ngct_valuation_data OPTIONAL
        !io_ngc_api_factory     TYPE REF TO cl_ngc_api_factory .