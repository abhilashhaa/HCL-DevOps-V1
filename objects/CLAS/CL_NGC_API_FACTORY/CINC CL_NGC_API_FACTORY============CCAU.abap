CLASS ltc_ngc_api_factory DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: create_class_ok FOR TESTING.
    METHODS: create_classification FOR TESTING.
    METHODS: get_api FOR TESTING.
ENDCLASS.


CLASS ltc_ngc_api_factory IMPLEMENTATION.

  METHOD class_setup.

  ENDMETHOD.


  METHOD class_teardown.

  ENDMETHOD.


  METHOD setup.

  ENDMETHOD.


  METHOD teardown.

  ENDMETHOD.


  METHOD create_class_ok.

    DATA(ls_class_data) = VALUE ngcs_class( classinternalid               = '0000005905'
                                            classtype                     = '001'
                                            class                         = 'HARRI_COMPUTER'
                                            classstatus                   = '1'
                                            classsearchauthgrp            = ''
                                            classclassfctnauthgrp         = ''
                                            classmaintauthgrp             = ''
                                            documentinforecorddocnumber   = ''
                                            documentinforecorddoctype     = ''
                                            documentinforecorddocpart     = ''
                                            documentinforecorddocversion  = ''
                                            sameclassfctnreaction         =  'X'
                                            clfnorganizationalarea        = ''
                                            classstandardorgname          = ''
                                            classstandardnumber           = ''
                                            classstandardstartdate        = '00000000'
                                            classstandardversionstartdate = '00000000'
                                            classstandardversion          = '00'
                                            classstandardcharctable       = ''
                                            classislocal                  = ''
                                            validitystartdate             = '20170111'
                                            validityenddate               = '99991231'
*                                            keydate                       = '20170120'
                                            classtext                     = ''
                                            classdescription              = 'computer' ).

    DATA(lo_class) = cl_ngc_api_factory=>get_instance( )->create_class_with_charcs(
                                                            is_class_header                = ls_class_data
                                                            it_class_characteristics       = VALUE #( )
                                                            it_class_characteristic_values = VALUE #( ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_class
                                       msg = 'Class Instance is not bound' ).

  ENDMETHOD.


  METHOD create_classification.

    DATA(lo_classification) = cl_ngc_api_factory=>get_instance( )->create_classification( is_classification_key = VALUE #( object_key       = 'TEST_FOCUS_OBJECT'
                                                                                                                           technical_object = 'TESTTAB'
                                                                                                                           change_number    = ''
                                                                                                                           key_date         = '20170111' ) ).

    cl_abap_unit_assert=>assert_bound( act = lo_classification
                                       msg = 'Classification Instance is not bound' ).

  ENDMETHOD.


  METHOD get_api.

    DATA(lo_api) = cl_ngc_api_factory=>get_instance( )->get_api( ).

    cl_abap_unit_assert=>assert_bound( act = lo_api
                                       msg = 'API Instance is not bound' ).

  ENDMETHOD.

ENDCLASS.