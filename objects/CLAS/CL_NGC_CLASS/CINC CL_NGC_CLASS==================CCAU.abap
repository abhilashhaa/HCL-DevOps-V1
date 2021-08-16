CLASS ltd_cls_persistency DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES: if_ngc_core_cls_persistency PARTIALLY IMPLEMENTED.
  PRIVATE SECTION.
ENDCLASS.

CLASS ltd_cls_persistency IMPLEMENTATION.
  METHOD if_ngc_core_cls_persistency~read_by_internal_key.
  ENDMETHOD.
ENDCLASS.

CLASS lth_ngc_class_testdata DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA: gs_class_data TYPE ngcs_class.
    CLASS-METHODS: class_constructor.
ENDCLASS.

CLASS lth_ngc_class_testdata IMPLEMENTATION.

  METHOD class_constructor.

    gs_class_data = VALUE #( classinternalid               = '0000005905'
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
                             clfnorganizationalarea	       = ''
                             classstandardorgname	         = ''
                             classstandardnumber           = ''
                             classstandardstartdate	       = '00000000'
                             classstandardversionstartdate = '00000000'
                             classstandardversion	         = '00'
                             classstandardcharctable       = ''
                             classislocal	                 = ''
                             validitystartdate             = '20170111'
                             validityenddate               = '99991231'
*                             keydate                       = '20170120'
                             classtext                     = ''
                             classdescription	             = 'computer' ).

  ENDMETHOD.

ENDCLASS.

CLASS ltc_ngc_class DEFINITION DEFERRED.
CLASS cl_ngc_class DEFINITION LOCAL FRIENDS ltc_ngc_class.

CLASS ltc_ngc_class DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_class.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: get_header FOR TESTING.
    METHODS: get_characteristics FOR TESTING.
ENDCLASS.


CLASS ltc_ngc_class IMPLEMENTATION.

  METHOD class_setup.

  ENDMETHOD.


  METHOD class_teardown.

  ENDMETHOD.


  METHOD setup.

    mo_cut = NEW cl_ngc_class( is_class_header = lth_ngc_class_testdata=>gs_class_data ).

  ENDMETHOD.


  METHOD teardown.

  ENDMETHOD.


  METHOD get_header.

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Class instance not bound' ).

    DATA(ls_class_data) = mo_cut->if_ngc_class~get_header( ).

    cl_abap_unit_assert=>assert_equals( act = ls_class_data
                                        exp = lth_ngc_class_testdata=>gs_class_data
                                        msg = 'Get_header returned with unexpected data' ).

  ENDMETHOD.

  METHOD get_characteristics.

    cl_abap_unit_assert=>assert_bound( act = mo_cut
                                       msg = 'Class instance not bound' ).

    mo_cut->mv_characteristics_populated = abap_true.

    mo_cut->if_ngc_class~get_characteristics(
      IMPORTING
        et_characteristic          = DATA(lt_characteristic)
        et_characteristic_org_area = DATA(lt_characteristic_org_area)
        eo_cls_api_result          = DATA(lo_cls_api_result)
    ).

    cl_abap_unit_assert=>assert_initial( act = lt_characteristic
                                         msg = 'get_characteristics returned unexpected data' ).

    cl_abap_unit_assert=>assert_initial( act = lt_characteristic_org_area
                                         msg = 'get_characteristics returned unexpected data' ).

    cl_abap_unit_assert=>assert_initial( act = lo_cls_api_result->get_messages( )
                                         msg = 'get_characteristics returned unexpected data' ).

  ENDMETHOD.

ENDCLASS.