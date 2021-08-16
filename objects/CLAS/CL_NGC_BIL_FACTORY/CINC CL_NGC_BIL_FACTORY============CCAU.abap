CLASS ltc_ngc_bil_factory DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS: get_classification FOR TESTING.
    METHODS: get_classification_eml FOR TESTING.
    METHODS: get_class FOR TESTING.
    METHODS: get_characteristic FOR TESTING.
ENDCLASS.

CLASS ltc_ngc_bil_factory IMPLEMENTATION.

  METHOD get_classification.

    DATA(lo_instance) = cl_ngc_bil_factory=>get_classification( ).

    cl_abap_unit_assert=>assert_bound( act = lo_instance
                                       msg = 'Classification instance is not bound' ).

  ENDMETHOD.

  METHOD get_classification_eml.

    DATA(lo_instance) = cl_ngc_bil_factory=>get_classification_eml( ).

    cl_abap_unit_assert=>assert_bound( act = lo_instance
                                       msg = 'Classification EML instance is not bound' ).

  ENDMETHOD.

  METHOD get_class.

    DATA(lo_instance) = cl_ngc_bil_factory=>get_class( ).

    cl_abap_unit_assert=>assert_bound( act = lo_instance
                                       msg = 'Class instance is not bound' ).

  ENDMETHOD.

  METHOD get_characteristic.

    DATA(lo_instance) = cl_ngc_bil_factory=>get_characteristic( ).

    cl_abap_unit_assert=>assert_bound( act = lo_instance
                                       msg = 'Characteristic instance is not bound' ).

  ENDMETHOD.

ENDCLASS.